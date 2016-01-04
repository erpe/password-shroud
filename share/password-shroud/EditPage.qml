import QtQuick 2.4
import Ubuntu.Components 1.2

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
        console.log("items in store: " + ctrl.items.len) 

        if (ret == true) {
          decryptResponse.text = ""
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
  }
}
