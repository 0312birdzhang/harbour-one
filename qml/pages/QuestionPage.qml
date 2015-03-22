//import QtQuick 1.1
//import com.nokia.symbian 1.1
import QtQuick 2.0
import Sailfish.Silica 1.0
import QtWebKit 3.0
import "main.js" as Script

Page {
    id: questionPage;

    property bool firstStart: true
    onVisibleChanged: {
        if (visible && firstStart){
            firstStart = false;
            Script.questionModel = questionModel;
            preload(0);
            view.currentIndexChanged.connect(preload);
        }
    }

    function preload(index){
        if (index == undefined)
            index = view.currentIndex;
        Script.preloadQuestionModel(index);
        Script.preloadQuestionModel(index+1);
        Script.preloadQuestionModel(index+2);
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
        id: questionModel;
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
        interactive: currentItem != null && !currentItem.moving
        model: questionModel;
        delegate: questionDel;
        Component {
            id: questionDel;

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
                    visible: root.ListView.isCurrentItem && model.questionAdEntity == undefined;
                }

                Flickable {
                    id: flickable;
                    anchors.fill: parent;
                    clip: true;
                    contentWidth: width;
                    contentHeight: contentCol.height;
                    visible: model.questionAdEntity ? true : false;
                    interactive: !view.moving;

                    Column {
                        id: contentCol
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

                        Item {
                            width: parent.width;
                            height: childrenRect.height;

                            Image {
                                id: questionIcon
                                source: "pics/one_question_page_question_image.png"
                            }
                            ListItemText {
                                anchors {
                                    left: questionIcon.right; leftMargin: platformStyle.paddingSmall;
                                    right: parent.right;
                                }
                                wrapMode: Text.Wrap
                                elide: Text.ElideNone;
                                text: model.questionAdEntity ? model.questionAdEntity.strQuestionTitle : ""
                                platformInverted: true;
                            }
                        }

                        Label {
                            width: parent.width;
                            text: model.questionAdEntity ? model.questionAdEntity.strQuestionContent : ""
                            wrapMode: Text.Wrap;
                            platformInverted: true;
                        }

                        Rectangle {
                            width: parent.width;
                            height: 2;
                            color: platformStyle.colorNormalMid
                        }

                        Item {
                            width: parent.width;
                            height: childrenRect.height;

                            Image {
                                id: answerIcon
                                source: "pics/one_question_page_answer.png"
                            }
                            ListItemText {
                                anchors {
                                    left: answerIcon.right; leftMargin: platformStyle.paddingSmall;
                                    right: parent.right;
                                }
                                wrapMode: Text.Wrap
                                elide: Text.ElideNone;
                                text: model.questionAdEntity ? model.questionAdEntity.strAnswerTitle : ""
                                platformInverted: true;
                            }
                        }

                        Loader {
                            width: parent.width;
                            sourceComponent: visible && root.ListView.isCurrentItem && !view.moving && model.questionAdEntity ? webViewComp : sourceComponent
                            Component {
                                id: webViewComp;
                                WebView {
                                    preferredWidth: parent.width;
                                    preferredHeight: preferredWidth;
                                    html: model.questionAdEntity.strAnswerContent
                                    settings {
                                        defaultFontSize: platformStyle.fontSizeMedium;
                                        defaultFixedFontSize: platformStyle.fontSizeMedium;
                                        minimumFontSize: platformStyle.fontSizeMedium;
                                        minimumLogicalFontSize: platformStyle.fontSizeMedium;
                                    }
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
}
