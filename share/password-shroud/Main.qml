import QtQuick 2.4
import Ubuntu.Components 1.2

MainView {
  objectName: "mainView"
  applicationName: "password-shroud.rene-so36"
  //automaticOrientation: true
  pageStack: introPage
  width: units.gu(100)
  height: units.gu(75)
  //backgroundColor: UbuntuColors.darkAubergine

  PageStack {
    id: myPages
    Component.onCompleted: myPages.push(introPage)

    IntroPage{ id: introPage } 
    EditPage{ id: editPage } 
    ListPage{ id: listPage } 
    CreatePage{ id: createPage }
    AddEntryPage{ id: addEntryPage }
    
  }
}
