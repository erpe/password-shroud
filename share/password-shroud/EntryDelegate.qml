import QtQuick 2.4
import Ubuntu.Components 1.2
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
        color: UbuntuColors.orange
        iconName: "find"
        text: "show"
        onClicked: {
          dialog.text = ctrl.items.get(index).pass
        }
      }
      Button {
        color: UbuntuColors.lightGrey
        iconName: "edit-copy"
        text: "copy to clipboard"
        onClicked: {
          Clipboard.push( ctrl.items.get(index).pass )
        }
      }
      Button {
        color: UbuntuColors.lightGrey
        iconName: "undo"
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
    spacing: units.gu(4)
    Row {
      spacing: units.gu(2)
      Label {
        text: ctrl.items.get(index).name
        font.bold: true
      }
      Label {
        text: ctrl.items.get(index).url
      }
      Label {
        id: passLabel
        text: "*" //ctrl.items.get(index).pass
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
          //editPage.ngLabel = "neue variante"
          //editPage.passwdField.text = "geheim"
          addEntryPage.title = "Edit entry"
          myPages.push(addEntryPage)
          //PopupUtils.open(dialogComp)
          //console.log("show triggered for: " + index)
        }
      },
      **/
      Action {
        id: copyClipBoardAction
        text: "copy"
        description: "copies password to clipboard"
        iconName: "edit-copy"
        onTriggered: {
          //console.log("copyClipboard triggered for " + ctrl.items.get(index).pass)
          Clipboard.push( ctrl.items.get(index).pass )
        }
      }
    ]
  }
  onClicked: {
    console.log("entry clicked...")
    PopupUtils.open(dialogComp)
  }
}
