import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id: morePage;

    orientationLock: PageOrientation.LockPortrait

    Flickable {
        anchors {
            fill: parent;
        }
        contentWidth: width;
        contentHeight: contentCol.height;
        clip: true;

        Column {
            id: contentCol;
            width: parent.width;
            ListItem {
                subItemIndicator: true;
                platformInverted: true;
                ListItemText {
                    anchors {
                        left: parent.paddingItem.left; verticalCenter: parent.verticalCenter
                    }
                    text: qsTr("Copyright")
                    platformInverted: true;
                }
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }

            ListItem {
                subItemIndicator: true;
                platformInverted: true;
                ListItemText {
                    anchors {
                        left: parent.paddingItem.left; verticalCenter: parent.verticalCenter;
                    }
                    text: qsTr("Quit")
                    platformInverted: true;
                }
                onClicked: Qt.quit();
            }
        }
    }
}
