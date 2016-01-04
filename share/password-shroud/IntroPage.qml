import QtQuick 2.4
import Ubuntu.Components 1.2

Page {
  id: introPage
  title: i18n.tr("Password-Shroud")
  visible: false
  Image {
    id: logo
    source: "../images/key.png"
    sourceSize.width: units.gu(30)
    sourceSize.height: units.gu(50)
    fillMode: Image.PreserveAspectFit
    anchors {
      margins: units.gu(2)
      top: parent.top
      left: parent.left
      right: parent.right
    }
  }
  Button {
    id: openButton
    text: i18n.tr("Open stored passwords")
    strokeColor: UbuntuColors.orange
    anchors {
      centerIn: parent
      margins: units.gu(2)
    }
    onClicked: {
      myPages.push(editPage)
    }
  }
}
