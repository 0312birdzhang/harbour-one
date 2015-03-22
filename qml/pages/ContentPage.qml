import QtQuick 1.1
import com.nokia.symbian 1.1
import QtWebKit 1.0
import "main.js" as Script


Page {
    id: contentPage;

    property bool firstStart: true

    onVisibleChanged: {
        if (visible && firstStart){
            firstStart = false;
            Script.contentModel = contentModel;
            preload(0);
            view.currentIndexChanged.connect(preload);
        }
    }

    function preload(index){
        if (!contentModel.hasPrev)
            return;
        if (index == undefined){
            index = view.currentIndex;
        }
        Script.preloadContentModel(index);
        Script.preloadContentModel(index+1);
        Script.preloadContentModel(index+2);
    }

    function addToFavorite(){
        if (contentModel.count > 0){
            var data = contentModel.get(view.currentIndex).contentEntity
            if (data){
                var title = data.strContTitle
                var date = contentModel.get(view.currentIndex).date
                signalCenter.addToFavorite(date, title)
            }
        }
    }

    function share(via){
        if (via == "email"){
            if (contentModel.count > 0){
                var data = contentModel.get(view.currentIndex).contentEntity
                if (data){
                    var title = data.strContTitle;
                    var content = data.strContent;
                    Qt.openUrlExternally("mailto:?subject="+encodeURIComponent(title)+"&body="+encodeURIComponent(title))
                }
            }
        }
    }

    orientationLock: PageOrientation.LockPortrait

    Connections {
        target: signalCenter;
        onHeaderClicked: {
            if (visible){
                view.positionViewAtBeginning();
            }
        }
    }

    ListModel {
        id: contentModel;
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
        interactive: currentItem!=null && !currentItem.moving
        model: contentModel;
        delegate: contentDel;
        cacheBuffer: width;

        Component {
            id: contentDel;
            Item {
                id: root;

                property alias moving: flickable.moving;

                width: view.width;
                height: view.height;

                BusyIndicator {
                    anchors.centerIn: parent;
                    platformInverted: true;
                    width: platformStyle.graphicSizeLarge;
                    height: platformStyle.graphicSizeLarge;
                    running: true;
                    visible: root.ListView.isCurrentItem && model.contentEntity == undefined;
                }

                Flickable {
                    id: flickable;
                    anchors.fill: parent;
                    clip: true;
                    contentWidth: width;
                    contentHeight: contentCol.height;
                    visible: model.contentEntity ? true : false;
                    interactive: !view.moving;

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
                                    var dateAry = model.date.split("-");
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
                            text: model.contentEntity ? model.contentEntity.strContTitle : ""
                            platformInverted: true;
                            font.pixelSize: platformStyle.fontSizeLarge+4;
                        }

                        ListItemText {
                            text: model.contentEntity ? model.contentEntity.strContAuthor : ""
                            platformInverted: true;
                            role: "SubTitle";
                        }

                        Loader {
                            width: parent.width;
                            sourceComponent: visible && root.ListView.isCurrentItem && !view.moving && model.contentEntity ? webViewComp : sourceComponent;
                            Component {
                                id: webViewComp
                                WebView {
                                    preferredWidth: parent.width;
                                    preferredHeight: preferredWidth;
                                    html: model.contentEntity.strContent;
                                    settings {
                                        defaultFontSize: platformStyle.fontSizeLarge;
                                        defaultFixedFontSize: platformStyle.fontSizeLarge;
                                        minimumFontSize: platformStyle.fontSizeLarge;
                                        minimumLogicalFontSize: platformStyle.fontSizeLarge;
                                    }
                                }
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
}
