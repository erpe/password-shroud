import QtQuick 2.4
import Ubuntu.Components 1.2

Page {
  id: addEntryPage
  title: i18n.tr("add new secret")
  visible: false
  Column {
    spacing: units.gu(1)
    anchors.margins: units.gu(2)
    width: parent.width
    ListView {
      width: parent.width

      Column {
        anchors.margins: units.gu(2)
        anchors.fill: parent 

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
          anchors.margins: units.gu(2)
        }

        Label {
          text: "secret"
        }
        TextField {
          id: inputPasswordField
          echoMode: TextInput.PasswordEchoOnEdit
          width: parent.width
          anchors.margins: units.gu(2)
        }

        Button {
          text: "Add new Entry"
          color: UbuntuColors.orange
          width: parent.width
          onClicked: {
            var ret = ctrl.addentry(inputNameField.text, inputUrlField.text, inputPasswordField.text)
            if (ret == true) {
              myPages.push(listPage)
            } else {
              console.log("could not add entry ")
            }
          }
        }
      }
    }
  }
}
