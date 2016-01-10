import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
  id: editPage
  title: i18n.tr("edit password-shroud")
  visible: false
  onActiveChanged: {
    passwdField.text = ""
  }
  
  Column { 
    spacing: units.gu(2)
    width: parent.width
    anchors {
      top: parent.top
      left: parent.left
      right: parent.right
      margins: units.gu(2)
    }
    Label {
      id: ngLabel
      objectName: "label"
      text: i18n.tr("provide your mantra...")
    }
    TextField {
      id: passwdField
      width: parent.width
      cursorVisible: true
      echoMode: TextInput.PasswordEchoOnEdit
      hasClearButton: true
    }
    Button {
      id: passBtn
      text: i18n.tr("Decrypt password shroud")
      color: UbuntuColors.green
      anchors.horizontalCenter: parent.horizontalCenter
      
      onClicked: {
        var ret = ctrl.openshroud(passwdField.text) 
        if (ret == true) {
          decryptResponse.text = ""
          populate()
          myPages.push(listPage)
        } else {
          decryptResponse.text = i18n.tr("Wrong mantra supplied?")
        }
      }
    }

    Label {
      id: decryptResponse
      color: UbuntuColors.purple
      text: ""
    }
    Label {
      color: UbuntuColors.orange
      text: "This is an alpha version - beware!\nYour initially supplied mantra will be used\n as passphrase to encrypt your data.\n Choose well!"
    }
  }

  function populate() {
    if (newListModel.count > 0){
      newListModel.clear()
    }
    console.log("init model")
    for (var i = 0; i < ctrl.items.len; i++){
      newListModel.insert(i,{"name":ctrl.items.get(i).name, "url":ctrl.items.get(i).url})
    }
  }
}
