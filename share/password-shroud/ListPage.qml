import QtQuick 2.4
import Ubuntu.Components 1.3

Page {
  id: listPage
  title: ctrl.items.len + " " + i18n.tr("entries")
  visible: false
  head.actions: [
    Action {
      iconName: "add"
      onTriggered: myPages.push(addEntryPage)
    },
    Action {
      iconName: "settings"
      onTriggered: myPages.push(settingsPage)
    }
  ]
  
  UbuntuListView {
    id: entryListView
    width: parent.width
    height: parent.height
    model: newListModel
    delegate: EntryDelegate{}
  }

  BottomEdgeHint {
    id: edgeHint
    text: i18n.tr("Add Entry") 
    onClicked: {
      myPages.push(addEntryPage)
    }
  }
}
