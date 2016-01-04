import QtQuick 2.4
import Ubuntu.Components 1.2

Page {
  id: addEntryPage
  title: i18n.tr("add new secret")
  visible: false
  Column {
    id: formElements
    spacing: units.gu(2)
    width: parent.width
    anchors {
      top: parent.top
      left: parent.left
      right: parent.right
      margins: units.gu(2)
    }

    Label {
      text: "name"
    }
    TextField {
      id: inputNameField
      text: "name"
      width: parent.width
    }

    Label {
      text: "url"
    }
    TextField {
      id: inputUrlField
      width: parent.width
    }

    Label {
      text: "secret"
    }
    TextField {
      id: inputPasswordField
      echoMode: TextInput.PasswordEchoOnEdit
      width: parent.width
    }
  }
  Button {
    text: i18n.tr("Create new entry")
    strokeColor: UbuntuColors.orange
    anchors {
      margins: units.gu(2)
      top: formElements.bottom
      horizontalCenter: parent.horizontalCenter
    }
    onClicked: {
      var ret = ctrl.addentry(inputNameField.text, inputUrlField.text, inputPasswordField.text)
      if (ret == true) {
        myPages.pop(addEntryPage)
        myPages.push(listPage)
      } else {
        console.log("could not add entry ")
        createResponse.text = "could not add entry... its a desaster..."
      }
    }
  }
  Label {
    id: createResponse
    color: UbuntuColors.purple
    text: ""
  }
}
