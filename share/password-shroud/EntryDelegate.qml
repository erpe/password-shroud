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
        color: UbuntuColors.orange
        text: i18n.tr("show login and password")
        onClicked: {
          dialog.text =  "login: " + ctrl.items.get(index).login + "\n" +  "secret: " + ctrl.items.get(index).pass
        }
      }
      Button {
        color: UbuntuColors.green
        text: i18n.tr("copy login to clipboard")
        onClicked: {
          Clipboard.push( ctrl.items.get(index).login )
        }
      }

      Button {
        color: UbuntuColors.green
        text: i18n.tr("copy password to clipboard")
        onClicked: {
          Clipboard.push( ctrl.items.get(index).pass )
        }
      }
      Button {
        color: UbuntuColors.lightGrey
        text: i18n.tr("cancel")
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
    Row {
      spacing: units.gu(2)
      Label {
        text: name
        font.bold: true
        color: UbuntuColors.purple
      }
      Label {
        text: url
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
          ctrl.delete(index)
          newListModel.remove(index)
        }
      }
    ]
  }
  trailingActions: ListItemActions {

    actions: [
      Action {
        id: editAction
        iconName: i18n.tr("edit")
        onTriggered: {
          editEntryPage.listIndex = index
          editEntryPage.prepareForm()
          myPages.push( editEntryPage )
        }
      },
      Action {
        id: copyClipBoardAction
        text: i18n.tr("copy")
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
