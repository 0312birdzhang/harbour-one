//import QtQuick 1.1
//import com.nokia.symbian 1.1
import QtQuick 2.0
import Sailfish.Silica 1.0
Page {
    id: mainPage

    //orientationLock: PageOrientation.LockPortrait

    ViewHeader {
        id: viewHeader;
//        ToolButton {
//            anchors {
//                right: parent.right; rightMargin: Theme.paddingMedium;
//                verticalCenter: parent.verticalCenter;
//            }
//            iconSource: "toolbar-share";
//            platformInverted: true;
//            visible: tabGroup.currentTab == contentPage;
//            onClicked: mainMenu.open();
//        }
        onClicked: signalCenter.headerClicked()
    }

    ContextMenu {
        id: mainMenu;
            MenuItem {
                text: qsTr("Share Via E-Mail")
                visible: false;
                onClicked: contentPage.share("email")
            }
            MenuItem {
                text: qsTr("Add To Favorite");
                onClicked: contentPage.addToFavorite()
            }

    }

    TabGroup {
        id: tabGroup;
        anchors {
            fill: parent; topMargin: viewHeader.height; bottomMargin: buttonRow.height;
        }
        HomePage {
            id: homePage;
            pageStack: mainPage.pageStack;
        }
        ContentPage {
            id: contentPage;
            pageStack: mainPage.pageStack;
        }
        QuestionPage {
            id: questionPage;
            pageStack: mainPage.pageStack;
        }
        StowPage {
            id: stowPage;
            pageStack: mainPage.pageStack;
        }
        MorePage {
            id: detailsPage;
            pageStack: mainPage.pageStack;
        }
    }

    Row {
        id: buttonRow;
        anchors.bottom: parent.bottom;
        OneTabButton {
            icon: "home";
            tab: homePage;
        }
        OneTabButton {
            icon: "content";
            tab: contentPage;
        }
        OneTabButton {
            icon: "question";
            tab: questionPage;
        }
        OneTabButton {
            icon: "stow";
            tab: stowPage;
        }
        OneTabButton {
            icon: "details";
            tab: detailsPage;
        }
    }
}
