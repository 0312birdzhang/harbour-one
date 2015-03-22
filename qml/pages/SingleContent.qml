//import QtQuick 1.1
//import com.nokia.symbian 1.1
import QtQuick 2.0
import Sailfish.Silica 1.0
import QtWebKit 3.0
import "main.js" as Script

Page {
    id: singleContent

    property string date
    property variant contentEntity

    function getData(){
        Script.getContentData(date)
    }

    //orientationLock: PageOrientation.LockPortrait

    Connections {
        target: signalCenter;
        onGetContentDataFinished: {
            contentEntity = data
        }
    }

    ViewHeader {
        id: viewHeader
        ToolButton {
            anchors {
                left: parent.left; leftMargin: platformStyle.paddingMedium;
                verticalCenter: parent.verticalCenter;
            }
            iconSource: "toolbar-back";
            platformInverted: true;
            onClicked: pageStack.pop();
        }
        ToolButton {
            anchors {
                right: parent.right; rightMargin: platformStyle.paddingMedium;
                verticalCenter: parent.verticalCenter;
            }
            iconSource: "toolbar-share";
            platformInverted: true;
            onClicked: contentMenu.open();
        }
    }

    ContextMenu {
        id: contentMenu
        content: MenuLayout {
            MenuItem {
                text: qsTr("Remove From Favorite")
                onClicked: signalCenter.removeFromFavorite(date)
            }
        }
    }

    BusyIndicator {
        anchors.centerIn: parent;
        platformInverted: true;
        width: platformStyle.graphicSizeLarge;
        height: platformStyle.graphicSizeLarge;
        running: true;
        visible: contentEntity ? false : true;
    }

    Loader {
        id: contentLoader;
        anchors {
            fill: parent; topMargin: viewHeader.height
        }
        sourceComponent: contentEntity ? contentDel : undefined;
    }

    Component {
        id: contentDel;
        Item {
            id: root;

            Flickable {
                id: flickable;
                anchors.fill: parent;
                clip: true;
                contentWidth: width;
                contentHeight: contentCol.height;

                Column {
                    id: contentCol;
                    anchors {
                        left: parent.left; right: parent.right;
                        margins: platformStyle.paddingLarge;
                    }
                    spacing: platformStyle.paddingLarge;

                    Item { width: 1; height: 1 }

                    Column {
                        width: parent.width;
                        spacing: platformStyle.paddingSmall;
                        Rectangle {
                            width: parent.width;
                            height: 2;
                            color: platformStyle.colorNormalMid
                        }
                        ListItemText {
                            platformInverted: true;
                            text: {
                                var dateAry = contentEntity.strContMarketTime.split("-");
                                var date = new Date();
                                date.setFullYear(dateAry[0]);
                                date.setMonth(dateAry[1]-1);
                                date.setDate(dateAry[2]);
                                return Qt.formatDate(date, "MMMM dd, yyyy");
                            }
                        }

                        Rectangle {
                            width: parent.width;
                            height: 2;
                            color: platformStyle.colorNormalMid
                        }
                    }

                    Label {
                        text: contentEntity.strContTitle
                        platformInverted: true;
                        font.pixelSize: platformStyle.fontSizeLarge+4;
                    }

                    ListItemText {
                        text: contentEntity.strContAuthor
                        platformInverted: true;
                        role: "SubTitle";
                    }

                    WebView {
                        preferredWidth: parent.width;
                        preferredHeight: preferredWidth;
                        html: contentEntity.strContent;
                        settings {
                            defaultFontSize: platformStyle.fontSizeLarge;
                            defaultFixedFontSize: platformStyle.fontSizeLarge;
                            minimumFontSize: platformStyle.fontSizeLarge;
                            minimumLogicalFontSize: platformStyle.fontSizeLarge;
                        }
                    }
                }
            }
            ScrollDecorator {
                flickableItem: flickable;
            }
        }
    }
}
