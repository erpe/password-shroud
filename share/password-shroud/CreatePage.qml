import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
  id: createPage
  title: i18n.tr("create a new password-safe")
  visible: false
  Column {
    spacing: units.gu(1)
    anchors.margins: units.gu(2)
    Label {
      id: createLabel
      objectName: "label"
      text: i18n.tr("creating a new store...")
    }
  }
}
