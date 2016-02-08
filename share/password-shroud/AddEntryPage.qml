import QtQuick 2.4
import Ubuntu.Components 1.3

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
      width: parent.width
    }

    Label {
      text: "login"
    }
    TextField {
      id: inputLoginField
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
    color: UbuntuColors.orange
    anchors {
      margins: units.gu(2)
      top: formElements.bottom
      horizontalCenter: parent.horizontalCenter
    }
    onClicked: {
      var ret = ctrl.addentry(inputNameField.text, inputLoginField.text, inputUrlField.text, inputPasswordField.text)
      if (ret == true) {
        newListModel.append({"name":inputNameField.text, "login":inputLoginField.text, "url":inputUrlField.text})
        myPages.pop()
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
