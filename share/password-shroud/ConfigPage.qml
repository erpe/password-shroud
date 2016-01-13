import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
  id: configPage
  title: i18n.tr("settings")
  visible: false

  Column {

    width: parent.width
    Column {
      width: parent.width

      ListItem {
        
        contentItem.anchors {
          leftMargin: units.gu(2) 
          rightMargin: units.gu(2) 
          bottomMargin: units.gu(2) 
          topMargin: units.gu(2) 
        }
        Row {
          Label {
            text: i18n.tr("change your existing mantra")
          }
          Icon {
            width: 20
            height: 20
            name: "go-next"
          }
        }
        onClicked: myPages.push(passwordPage)
      }

      ListItem {
        contentItem.anchors {
          leftMargin: units.gu(2) 
          rightMargin: units.gu(2) 
          bottomMargin: units.gu(2) 
          topMargin: units.gu(2) 
        }
        Label {
          text: i18n.tr("about")
        }

      }
    }
  }
}
