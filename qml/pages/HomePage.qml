import QtQuick 1.1
import com.nokia.symbian 1.1
import "main.js" as Script

Page {
    id: homePage;


    property bool firstStart: true
    onVisibleChanged: {
        if (visible && firstStart){
            firstStart = false;
            Script.homeModel = homeModel;
            preload(0);
            view.currentIndexChanged.connect(preload)
        }
    }

    //orientationLock: PageOrientation.LockPortrait

    Connections {
        target: signalCenter;
        onHeaderClicked: {
            if (visible){
                view.positionViewAtBeginning();
            }
        }
    }

    ListModel {
        id: homeModel;
        property bool hasPrev: true;
    }

    ListView {
        id: view;
        anchors.fill: parent;
        orientation: ListView.Horizontal;
        preferredHighlightBegin: 0;
        preferredHighlightEnd: width;
        highlightRangeMode: ListView.StrictlyEnforceRange;
        snapMode: ListView.SnapOneItem;
        model: homeModel;
        delegate: homeDel;

        Component {
            id: homeDel;

            Item {
                id: root;
                width: view.width;
                height: view.height;

                BusyIndicator {
                    anchors.centerIn: parent;
                    platformInverted: true;
                    width: platformStyle.graphicSizeLarge;
                    height: platformStyle.graphicSizeLarge;
                    running: true;
                    visible: root.ListView.isCurrentItem && model.hpEntity == undefined;
                }

                Flickable {
                    id: flickable;
                    visible: model.hpEntity ? true : false;
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
                                text: model.hpEntity ? model.hpEntity.strHpTitle : "";
                                platformInverted: true;
                            }
                            Rectangle {
                                width: parent.width;
                                height: 2;
                                color: platformStyle.colorNormalMid
                            }
                        }

                        Image {
                            sourceSize.width: parent.width;
                            source: model.hpEntity ? model.hpEntity.strThumbnailUrl : "";
                            MouseArea {
                                anchors.fill: parent;
                                onClicked: {
                                    pageStack.push(Qt.resolvedUrl("ImagePage.qml"), {imgUrl: model.hpEntity.strOriginalImgUrl})
                                }
                            }
                        }

                        Repeater {
                            model: hpEntity ? hpEntity.strAuthor.split("&") : []
                            ListItemText {
                                anchors.right: parent ? parent.right : undefined;
                                text: modelData;
                                platformInverted: true;
                            }
                        }

                        Item {
                            width: parent.width;
                            height: childrenRect.height;
                            Column {
                                id: dateShow;
                                Label {
                                    anchors.horizontalCenter: parent.horizontalCenter;
                                    font {
                                        pixelSize: platformStyle.graphicSizeMedium;
                                        weight: Font.Black;
                                    }
                                    text: model.date.split("-").pop();
                                    color: "#73DCFF"
                                }
                                ListItemText {
                                    anchors.horizontalCenter: parent.horizontalCenter;
                                    role: "SubTitle"
                                    text: {
                                        var dateAry = model.date.split("-");
                                        var date = new Date();
                                        date.setFullYear(dateAry[0]);
                                        date.setMonth(dateAry[1]-1);
                                        date.setDate(dateAry[2]);
                                        return Qt.formatDate(date, "MMM,yyyy");
                                    }
                                    platformInverted: true;
                                }
                            }
                            BorderImage {
                                anchors {
                                    left: dateShow.right; leftMargin: platformStyle.paddingSmall;
                                    right: parent.right;
                                }
                                height: contentLabel.height + platformStyle.paddingLarge*2
                                source: "pics/one_home_page_text.9.png"
                                border {
                                    left: 15; top: 25; right: 10; bottom: 10
                                }
                                Label {
                                    id: contentLabel
                                    anchors {
                                        left: parent.left; right: parent.right; top: parent.top;
                                        margins: platformStyle.paddingLarge;
                                    }
                                    text: model.hpEntity ? model.hpEntity.strContent : ""
                                    wrapMode: Text.Wrap;
                                }
                            }
                        }
                    }
                }
                ScrollDecorator {
                    platformInverted: true;
                    flickableItem: flickable;
                }
            }
        }
    }

    function preload(index){
        if (!homeModel.hasPrev)
            return;
        if (index == undefined){
            index = view.currentIndex;
        }
        Script.preloadHomeModel(index)
        Script.preloadHomeModel(index+1)
        Script.preloadHomeModel(index+2)
    }
}
