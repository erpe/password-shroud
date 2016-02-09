package shroud

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"github.com/satori/go.uuid"
	"golang.org/x/crypto/openpgp"
	"io/ioutil"
	"log"
	"os"
	"os/user"
	"strings"
)

type Entry struct {
	Name     string `json:"Name"`
	Login    string `json:"Login"`
	Url      string `json:"Url"`
	Password string `json:"Password"`
	Uid      string `json:"Uid"`
}

func (e Entry) combine() string {
	sa := []string{e.Uid, e.Name, e.Login, e.Url, e.Password}
	combined := strings.Join(sa, "::")
	return combined
}

type Shroud struct {
	path       string
	jsonBlob   []byte
	cypher     []byte
	plain      []byte
	passphrase string
	passwords  passwords
	initialize bool
}

func (sh *Shroud) SetPassphrase(pass string) {
	sh.passphrase = pass
}

func (sh *Shroud) PasswordEquals(pass string) bool {
	if sh.passphrase == pass {
		return true
	} else {
		return false
	}
}

func (sh *Shroud) user() *user.User {
	user, err := user.Current()
	if err != nil {
		check(err)
	}
	return user
}

func (sh *Shroud) GetEntries() []Entry {
	ets := sh.passwords.Entries
	return ets
}

func (sh *Shroud) Delete(uid string) bool {
	return sh.passwords.Destroy(uid)
}

type passwords struct {
	Entries []Entry `json:"entries"`
}

func (p *passwords) Destroy(uid string) bool {
	for ind, val := range p.Entries {
		if val.Uid == uid {
			log.Println("removing index: ", ind)
			p.Entries = append(p.Entries[:ind], p.Entries[ind+1:]...)
			return true
		}
	}
	return false
}

func (p *passwords) UpdateEntry(entry Entry) bool {
	for i, val := range p.Entries {
		if val.Uid == entry.Uid {
			log.Println("found entry to update by uid...")
			p.Entries[i].Name = entry.Name
			p.Entries[i].Login = entry.Login
			p.Entries[i].Url = entry.Url
			p.Entries[i].Password = entry.Password
			return true
		}
	}
	return false
}

// opens up the Shroud
func (sh *Shroud) Open() bool {
	log.Println("going to open shroud....")
	var ret bool
	if sh.hasShroudFile() {
		ret = sh.openDecrypt()
	} else {
		ret = sh.openInitialize()
	}
	if ret == false {
		log.Println("open: could not decrypt")
		return false
	}
	log.Println("opened...")
	return true
}

func CurrentShroud() *Shroud {
	user, err := user.Current()
	if err != nil {
		panic(err)
	}
	ret := Shroud{path: user.HomeDir + "/.local/share/password-shroud.rene-so36/shroud.dat"}
	return &ret
}

// writes out the the cypher to
// Shroud Path
func (sh *Shroud) Write() bool {
	err := ioutil.WriteFile(sh.path, sh.cypher, 0644)
	check(err)
	log.Println("writing cypher to file")
	return true
}

func (sh *Shroud) AddEntryFromText(name string, login string, url string, pass string) bool {
	uid := uuid.NewV4()
	return sh.AddEntry(Entry{name, login, url, pass, uid.String()})
}

// adds an Entry entry to shroud
func (sh *Shroud) AddEntry(entry Entry) bool {
	log.Println("about to add entry...")
	if sh.plain != nil {
		sh.passwords.Entries = append(sh.passwords.Entries, entry)
		return true
	} else {
		sh.passwords.Entries = append(sh.passwords.Entries, entry)
		return true
	}
}

func (sh *Shroud) UpdateEntry(uid string, name string, login string, url string, pass string) bool {
	e := Entry{name, login, url, pass, uid}
	ret := sh.passwords.UpdateEntry(e)
	if ret != true {
		log.Println("update Entry failed...")
		return false
	} else {
		return true
	}
}

// resets both cypher and plain
// to nil value
func (sh *Shroud) Clear() {
	sh.cypher = nil
	sh.plain = nil
	sh.passphrase = ""
}

// debugging: prints out decrypted
// shroud
func (sh *Shroud) PrintPlain() {
	t := sh.plain
	fmt.Println("printPlain: ", string(t))
	for _, e := range sh.passwords.Entries {
		log.Println("name: ", e.Name)
	}
}

func (sh *Shroud) openDecrypt() bool {
	f, err := os.Open(sh.path)
	if err != nil {
		log.Fatal("FATAL: ", err)
		return false
	}
	defer f.Close()
	prompted := false
	msg, err := openpgp.ReadMessage(f, nil, func(keys []openpgp.Key, symmetric bool) ([]byte, error) {
		if prompted == true {
			return nil, errors.New("wrong passphrase")
		} else {
			prompted = true
		}
		return []byte(sh.passphrase), nil
	}, nil)

	if err != nil {
		log.Println("openDecrypt: error decrypting....", err)
		return false
	}

	bytes, err := ioutil.ReadAll(msg.UnverifiedBody)
	if err != nil {
		log.Fatal(err)
		return false
	}
	sh.plain = bytes
	sh.unmarshalPlain()
	return true
}

// if there is no shrourd.dat -
// initialize with empty values
func (sh *Shroud) openInitialize() bool {
	sh.plain = []byte("")
	sh.passwords = passwords{}
	sh.initialize = true
	return true
}

func (sh *Shroud) Finalize() bool {
	if sh.Marshal() {
		if sh.Encrypt() {
			if sh.Write() {
				return true
			}
		}
	}
	return false
}

func (sh *Shroud) Marshal() bool {
	//sh.PrintPlain()
	jsonblob, err := json.Marshal(sh.passwords)
	if err != nil {
		log.Fatal(err)
		return false
	}
	sh.jsonBlob = jsonblob
	return true
}

func (sh *Shroud) unmarshalPlain() bool {
	pwds := passwords{}
	json.Unmarshal(sh.plain, &pwds)
	sh.passwords = pwds
	return true
}

func (sh *Shroud) Encrypt() bool {
	encBuf := bytes.NewBuffer(nil)
	crypter, err := openpgp.SymmetricallyEncrypt(encBuf, []byte(sh.passphrase), nil, nil)
	if err != nil {
		log.Fatal(err)
		return false
	}
	_, err = crypter.Write(sh.jsonBlob)
	crypter.Close()

	if err != nil {
		log.Fatal(err)
		return false
	}
	sh.cypher = encBuf.Bytes()
	return true
}

func (sh *Shroud) hasShroudFile() bool {
	if _, err := os.Stat(sh.path); os.IsNotExist(err) {
		log.Println("shroud dir not existing - we'll create one...")
		sh.initialize = true
		return false
	}
	return true
}

// generates a fake Entry
func FakeEntry() Entry {
	e := Entry{"github", "alias", "http://github.com", "xxxxx", ""}
	return e
}

// checks shroud-dir for existence
// returns false if it was not existing...
// true otherwise
func EnsureShroudExists() (bool, error) {
	user, err := user.Current()
	if err != nil {
		log.Println("no current user...wtf...")
		return false, err
	}
	if _, err := os.Stat(user.HomeDir + "/.local/share/password-shroud.rene-so36"); os.IsNotExist(err) {
		log.Println("shroud dir not existing - we'll create one...")
		err = os.MkdirAll(user.HomeDir+"/.local/share/password-shroud.rene-so36", 0700)
		if err != nil {
			return false, err
		}
		return true, nil
	} else {
		log.Println("found app-directory structure... continue...")
		return true, nil
	}
}

// checks error fo nil -
// otherwise panics
func check(e error) {
	if e != nil {
		panic(e)
	}
}
