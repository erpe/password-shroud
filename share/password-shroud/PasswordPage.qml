import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
  id: passwordPage
  title: i18n.tr("password change")
  visible: false
  Column {
    id: inputElements
    spacing: units.gu(2)
    width: parent.width
    anchors {
      top: parent.top
      left: parent.left
      right: parent.right
      margins: units.gu(2)
    }

    Label {
      text: i18n.tr("old mantra")
    }
    TextField {
      id: oldPasswordField
      width: parent.width
      cursorVisible: true
      echoMode: TextInput.PasswordEchoOnEdit
      hasClearButton: true
    }

    Label {
      text: i18n.tr("new mantra")
    }
    TextField {
      id: newPasswordField
      width: parent.width
      //cursorVisible: true
      echoMode: TextInput.PasswordEchoOnEdit
      hasClearButton: true
    }
  }
  Button {
    id: submitBtn
    text: i18n.tr("change password")
    color: UbuntuColors.orange
    anchors {
      margins: units.gu(2)
      top: inputElements.bottom
      horizontalCenter: parent.horizontalCenter
    }
    onClicked: {
      var ret = ctrl.updatepassword(oldPasswordField.text, newPasswordField.text) 
      if (ret == true) {
        myPages.pop(passwordPage)
      } else {
        output.text = ctrl.message
      }
    }
  }
  Label {
    anchors {
      margins: units.gu(2)
      top: submitBtn.bottom 
    }
    id: output
    text: ''
    color: UbuntuColors.purple
  }
}
