import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
  id: settingsPage
  title: i18n.tr("settings")
  visible: false

  Column {
    id: topList
    width: parent.width
    height: units.gu(20)
    spacing: units.gu(2)
    anchors {
      top: parent.top
      left: parent.left
      right: parent.right
      margins: units.gu(2)
    }
    Column {
      id: innerCol
      width: parent.width
      height: parent.height / 2

      ListItem {
        id: changePassItem      
        contentItem.anchors {
          leftMargin: units.gu(2) 
          rightMargin: units.gu(2) 
          bottomMargin: units.gu(2) 
          topMargin: units.gu(2) 
        }
        Row {
          Label {
            color: UbuntuColors.purple
            text: i18n.tr("change your existing masterpassword")
          }
          Icon {
            width: 20
            height: 20
            name: "go-next"
          }
        }
        onClicked: myPages.push(passwordPage)
      }
      Rectangle {
        width: parent.width
        anchors.top: changePassItem.bottom
        anchors {
          margins: units.gu(5)
        }
        Label {
          color: UbuntuColors.coolGrey
          text: "Version 0.2.3"
          fontSize: "small"
        }
      }
    }
  }
}
