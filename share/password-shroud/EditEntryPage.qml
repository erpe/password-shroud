import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
  //id: editEntryPage
  //Component.onCompleted: prepareForm()
  title: i18n.tr("edit entry")
  visible: false
  property int listIndex: -1 
  property string uid: ""
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
    text: i18n.tr("Update entry")
    color: UbuntuColors.orange
    anchors {
      margins: units.gu(2)
      top: formElements.bottom
      horizontalCenter: parent.horizontalCenter
    }
    onClicked: {
      console.log("UID: " + uid)
      console.log("name: " + inputNameField.text)
      console.log("login: " + inputLoginField.text)
      console.log("url: " + inputUrlField.text)
      console.log("pass: " + inputPasswordField.text)
      var ret = ctrl.updateentry(uid, inputNameField.text, inputLoginField.text, inputUrlField.text, inputPasswordField.text)
      //var ret = ctrl.updateentry("foo", "testname", "testlogin", "test-url", "foo55")
      //var ret = ctrl.testupdate("foo")
      if (ret == true) {
        myPages.pop()
      } else {
        console.log("could not update entry ")
        createResponse.text = "could not update entry... its a desaster..."
      }
    }
  }
  Label {
    id: createResponse
    color: UbuntuColors.purple
    text: ""
  }

  function prepareForm() {
    if (listIndex >= 0)  {
      uid = ctrl.items.get(listIndex).uid
      inputNameField.text =  ctrl.items.get(listIndex).name
      inputLoginField.text =  ctrl.items.get(listIndex).login
      inputUrlField.text =  ctrl.items.get(listIndex).url
      inputPasswordField.text =  ctrl.items.get(listIndex).pass
    }
  }
}
