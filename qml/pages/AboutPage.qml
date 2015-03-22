import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: aboutPage;


//    ViewHeader {
//        id: viewHeader;
//        ToolButton {
//            anchors {
//                left: parent.left; leftMargin: platformStyle.paddingMedium;
//                verticalCenter: parent.verticalCenter;
//            }
//            iconSource: "toolbar-back";
//            platformInverted: true;
//            onClicked: pageStack.pop();
//        }
//    }

    SilicaFlickable {
        anchors {
            fill: parent; topMargin: viewHeader.height;
        }
        clip: true;
        contentWidth: width;
        contentHeight: contentCol.height;

        Column {
            id: contentCol;
            anchors {
                left: parent.left; right: parent.right; margins: platformStyle.graphicSizeSmall;
            }
            spacing: platformStyle.paddingLarge;
            Item { width: 1; height: 1 }

            Label {
                text: qsTr("ONE")
                platformInverted: true;
                font {
                    pixelSize: platformStyle.graphicSizeMedium;
                }
                anchors.horizontalCenter: parent.horizontalCenter;
            }

            ListItemText {
                width: parent.width
                wrapMode: Text.Wrap;
                elide: Text.ElideNone;
                platformInverted: true;
                text: qsTr("Chief Editor: Han Han")
            }
            ListItemText {
                width: parent.width;
                wrapMode: Text.Wrap;
                elide: Text.ElideNone;
                platformInverted: true;
                text: qsTr("Executive Editor: Ma Yimu")
            }
            ListItemText {
                width: parent.width;
                wrapMode: Text.Wrap;
                elide: Text.ElideNone;
                platformInverted: true;
                text: qsTr("Deputy Executive Editor: Xiao Fan, Cai Lei")
            }
            ListItemText {
                width: parent.width;
                wrapMode: Text.Wrap;
                elide: Text.ElideNone;
                platformInverted: true;
                text: qsTr("Senior Editor: Zhang Guanren");
            }
            ListItemText {
                width: parent.width;
                wrapMode: Text.Wrap;
                elide: Text.ElideNone;
                platformInverted: true;
                text: qsTr("Editor: Jin Yi Yu Ling, Shen Chao, Jin Danhua, He Yiman")
            }
            ListItemText {
                width: parent.width;
                wrapMode: Text.Wrap;
                elide: Text.ElideNone;
                platformInverted: true;
                text: qsTr("Seniot VM Supervisor: Zhou Yunzhe")
            }
            ListItemText {
                width: parent.width;
                wrapMode: Text.Wrap;
                elide: Text.ElideNone;
                platformInverted: true;
                text: qsTr("Art Director: He He")
            }
            ListItemText {
                width: parent.width;
                wrapMode: Text.Wrap;
                elide: Text.ElideNone;
                platformInverted: true;
                text: qsTr("Software Coder: Yeatse")
            }
            ListItemText {
                width: parent.width;
                wrapMode: Text.Wrap;
                elide: Text.ElideNone;
                platformInverted: true;
                text: qsTr("Version: 1.2")
            }
            ListItemText {
                width: parent.width;
                wrapMode: Text.Wrap;
                elide: Text.ElideNone;
                platformInverted: true;
                text: qsTr("Copyright By Author, All Rights Reserved.")
            }
            Item { width: 1; height: 1 }
        }
    }
}
