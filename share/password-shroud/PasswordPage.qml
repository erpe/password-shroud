import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
  id: passwordPage
  title: i18n.tr("password change")
  visible: false
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
      text: "old mantra"
    }
    TextField {
      id: oldPasswordField
      width: parent.width
    }

    Label {
      text: "new mantra"
    }
    TextField {
      id: newPasswordField
      width: parent.width
    }
  }
}
