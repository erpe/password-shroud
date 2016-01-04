import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.0

ListItem {
  id: entryDelegate
  Component  {
    id: dialogComp
    Dialog {
      id: dialog
      title: ctrl.items.get(index).name
      text:  "***********"
      
      Button {
        strokeColor: UbuntuColors.orange
        text: "show"
        onClicked: {
          dialog.text = ctrl.items.get(index).pass
        }
      }
      Button {
        strokeColor: UbuntuColors.green
        text: "copy to clipboard"
        onClicked: {
          Clipboard.push( ctrl.items.get(index).pass )
        }
      }
      Button {
        color: UbuntuColors.lightGrey
        text: "cancel"
        onClicked: PopupUtils.close(dialog)
      }
    }
  }
  contentItem.anchors {
    leftMargin: units.gu(1)
    rightMargin: units.gu(1)
    topMargin: units.gu(1)
    bottomMargin: units.gu(1)
  }

  Row {
    //spacing: units.gu(4)
    Row {
      spacing: units.gu(2)
      Label {
        text: ctrl.items.get(index).name
        font.bold: true
        color: UbuntuColors.purple
      }
      Label {
        text: ctrl.items.get(index).url
      }
    }
  }
  leadingActions: ListItemActions {
    actions: [
      Action {
        id: deleteAction
        iconName: "delete"
        onTriggered: {
          console.log("delete triggered for: " + index)
        }
      }
    ]
  }
  trailingActions: ListItemActions {
    actions: [
      /**
      Action {
        id: editAction
        iconName: "edit"
        onTriggered: {
          addEntryPage.title = "Edit entry"
          myPages.push(addEntryPage)
        }
      },
      **/
      Action {
        id: copyClipBoardAction
        text: "copy"
        description: "copies password to clipboard"
        iconName: "edit-copy"
        onTriggered: {
          Clipboard.push( ctrl.items.get(index).pass )
        }
      }
    ]
  }
  onClicked: {
    PopupUtils.open(dialogComp)
  }
}
