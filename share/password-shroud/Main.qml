import QtQuick 2.4
import Ubuntu.Components 1.3

MainView {
  objectName: "mainView"
  applicationName: "password-shroud.rene-so36"
  pageStack: introPage
  width: units.gu(75)
  height: units.gu(100)

  ListModel {
    id: newListModel
    ListElement {
      name: ""
      url: ""
      pass: ""
    }
  }

  PageStack {
    id: myPages
    Component.onCompleted: myPages.push(introPage)

    IntroPage{ id: introPage } 
    EditPage{ id: editPage } 
    ListPage{ id: listPage } 
    CreatePage{ id: createPage }
    AddEntryPage{ id: addEntryPage }
    SettingsPage{ id: settingsPage }    
    PasswordPage{ id: passwordPage }
  }
}
