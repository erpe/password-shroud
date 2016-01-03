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
      //text: i18n.tr("your long mantra")
      text: ctrl.message
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
      text: i18n.tr("decrypt password-shroud")
      color: UbuntuColors.green
      width: parent.width
      
      onClicked: {
        //console.info(passwdField.text)
        var ret = ctrl.openshroud(passwdField.text) 
        console.log("items in store: " + ctrl.items.len) 

        if (ret == true) {
          myPages.push(listPage)
        }
      }
    }
  }
}
