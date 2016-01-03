import QtQuick 2.4
import Ubuntu.Components 1.2

Page {
  id: introPage
  title: i18n.tr("Password-Shroud")
  visible: false

  Button {
    id: openButton
    iconName: "lock-broken"
    text: i18n.tr("Open stored passwords")
    color: UbuntuColors.green
    anchors {
      top: parent.top
      left: parent.left
      right: parent.right
      margins: units.gu(2)
    }
    onClicked: {
      myPages.push(editPage)
    }
  }
  Button {
    text: i18n.tr("Create new Password-Safe")
    color: UbuntuColors.green
    //iconName: "go-to"
    //iconPosition: "left"
    visible: false
    anchors {
      top: openButton.bottom
      left: parent.left
      right: parent.right
      margins: units.gu(2)
    }
    onClicked: {
      myPages.push(createPage)
    }
  }
}
