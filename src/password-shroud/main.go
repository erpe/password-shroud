package main

import (
	"gopkg.in/qml.v1"
	"log"
	"password-shroud/shroud"
)

func main() {
	_, err := shroud.EnsureShroudExists()
	if err != nil {
		log.Fatal(err)
		panic(err)
	}

	err = qml.Run(run)
	if err != nil {
		log.Fatal(err)
	}
}

func run() error {
	items := NewItems()
	ctrl := Control{Message: "Pasword-Shroud..."}
	ctrl.Items = items

	engine := qml.NewEngine()
	context := engine.Context()
	context.SetVar("ctrl", &ctrl)

	component, err := engine.LoadFile("share/password-shroud/Main.qml")
	if err != nil {
		return err
	}
	win := component.CreateWindow(nil)
	ctrl.Root = win.Root()
	win.Show()
	win.Wait()
	return nil
}

type Control struct {
	Root    qml.Object
	Message string
	Shroud  *shroud.Shroud
	Items   *Items
}

type Item struct {
	Name string
	Url  string
	Pass string
	Uid  string
}

type Items struct {
	itemMap  map[string]*Item
	itemList []*Item
	Len      int
}

func (i *Items) add(item *Item) {
	i.itemMap[item.Name] = item
	i.itemList = append(i.itemList, item)
	i.Len++
}

func (i *Items) Get(index int) *Item {
	return i.itemList[index]
}

func (ctrl *Control) Delete(index int) {
	toDelItem := ctrl.Items.itemList[index]
	ret := ctrl.Shroud.Delete(toDelItem.Uid)
	ctrl.Shroud.Marshal()
	ctrl.Shroud.Encrypt()
	ctrl.Shroud.Write()
	if ret == true {
		log.Println("success deleting index: ", index)
	} else {
		log.Println("could not delete index: ", index)
	}
	o := ctrl.Shroud.Open()
	if o == true {
		ctrl.Items = NewItems()
		for _, val := range ctrl.Shroud.GetEntries() {
			ctrl.Items.add(&Item{Name: val.Name, Url: val.Url, Pass: val.Password, Uid: val.Uid})
		}
	}
	qml.Changed(ctrl, &ctrl.Items)
}

func NewItems() *Items {
	items := Items{itemMap: make(map[string]*Item)}
	return &items
}

func (ctrl *Control) Openshroud(pass string) bool {
	ctrl.Shroud = shroud.CurrentShroud()
	ctrl.Shroud.SetPassphrase(pass)
	ret := ctrl.Shroud.Open()
	if ret == true {
		ctrl.Items = NewItems()
		for _, val := range ctrl.Shroud.GetEntries() {
			ctrl.Items.add(&Item{Name: val.Name, Url: val.Url, Pass: val.Password, Uid: val.Uid})
		}
		ctrl.Message = "shroud open..."
		qml.Changed(ctrl, &ctrl.Message)
		qml.Changed(ctrl, &ctrl.Items)
		return true
	} else {
		ctrl.Message = "Wrong passphrase?"
		qml.Changed(ctrl, &ctrl.Message)
	}
	return false
}

func (ctrl *Control) Addentry(name string, url string, pass string) bool {
	ret := ctrl.Shroud.AddEntryFromText(name, url, pass)
	if ret == false {
		panic("could not add entry...")
	}
	ctrl.Shroud.Marshal()
	ret = ctrl.Shroud.Encrypt()
	if ret == false {
		panic("could not encrypt...")
	}
	ret = ctrl.Shroud.Write()
	o := ctrl.Shroud.Open()
	if o == true {
		ctrl.Items = NewItems()
		for _, val := range ctrl.Shroud.GetEntries() {
			ctrl.Items.add(&Item{Name: val.Name, Url: val.Url, Pass: val.Password, Uid: val.Uid})
		}
	}
	qml.Changed(ctrl, &ctrl.Items)
	return true
}

func (ctrl *Control) Updatepassword(oldpass string, newpass string) bool {
	if ctrl.Shroud.PasswordEquals(oldpass) {
		log.Println("correct passphrase supplied...")
		ctrl.Shroud.SetPassphrase(newpass)
		if ctrl.Shroud.Finalize() {
			log.Println("finalize success...")
			return true
		} else {
			ctrl.Message = "something weired happened..."
			log.Println("finalize failed...")
		}
	} else {
		ctrl.Message = "old passphrase was wrong..."
		log.Println("wrong passphrase supplied...")
	}
	qml.Changed(ctrl, &ctrl.Message)
	return false
}

//func (ctrl *Control) Getrandom() Item {
//	return ctrl.Items[1]
//}

//func (ctrl *Control) GetByIndex(index int) Item {
//	return ctrl.Items[index]
//}

//  sd := shroud.CurrentShroud()
//	sd.SetPassphrase("lamerx")
//	suc := sd.Open()
//	log.Println("suc: ", suc)
//	if suc == false {
//		log.Println("first pass was wrong")
//		sd.SetPassphrase("lamer")
//		sd.Open()
//	}
//	sd.PrintPlain()
//	de := shroud.FakeEntry()
//	ret := sd.AddEntry(de)
//	if ret == false {
//		panic("could not add entry")
//	}
//	sd.Marshal()
//	log.Println("added new entry")
//	ret = sd.Encrypt()
//	if ret == false {
//		panic("could not encrypt")
//	}
//	ret = sd.Write()
//	if ret == false {
//		panic("could not write file")
//	}
//	sd.Clear()
