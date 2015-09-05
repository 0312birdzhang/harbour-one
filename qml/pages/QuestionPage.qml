import QtQuick 2.0
import Sailfish.Silica 1.0
import "getOneQuestionInfo.js" as Script

Item {
    id: questionPage;
    //allowedOrientations: Orientation.Portrait | Orientation.Landscape
    property var strQuestionTitle:""
    property var strQuestionContent:""
    property var strAnswerTitle:""
    property var strAnswerContent:""
    property var strQuestionMarketTime:""
    height: mainView.height; width: mainView.width
    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: !PageStatus.Active
        size: BusyIndicatorSize.Large
    }
    Component.onCompleted: {
        Script.load(allindex);
        Script.tmp_index=allindex;
    }

    SilicaFlickable{
        id:listview
        anchors.fill: parent
        PageHeader{
            id:hearer
            title:qsTr("Question")
        }
        width: parent.width
        //clip:true

        contentHeight: date_time.height + questionicon.height + questionTitle.height+
                               questionContent.height+ answericon.height +
                               answerTitle.height + answerContent.height +
                               hearer.height + Theme.paddingLarge * 4
                VerticalScrollDecorator {}
                Label{
                    id:date_time
                    text:strQuestionMarketTime
                    color: Theme.secondaryColor
                    font.pixelSize:Theme.fontSizeExtraSmall
                    horizontalAlignment: Text.AlignLeft
                    truncationMode: TruncationMode.Elide
                    anchors{
                        top:hearer.bottom
                        left:parent.left
                        right:parent.right
                        margins: Theme.paddingMedium
                    }
                    Rectangle{
                        width: parent.width;
                        height: 1;
                        anchors.top: parent.bottom;
                        color: "#66ffffff"
                    }
                }

                Image {
                    id:questionicon
                    enabled: opacity === 1.0
                    source: "image://theme/icon-m-tabs"
                    width: Theme.iconSizeMedium ;
                    height: Theme.iconSizeMedium;
                    anchors{
                        left:parent.left;
                        leftMargin: Theme.paddingMedium
                        top:date_time.bottom;
                        topMargin: Theme.paddingMedium*2;
                    }
                    Label {
                        anchors {
                            centerIn: parent
                        }
                        font.pixelSize: Theme.fontSizeExtraSmall
                        font.bold: true
                        color: Theme.highlightColor;
                        horizontalAlignment: Text.AlignHCenter
                        text:"Q"
                    }
                }
                Label{
                    id:questionTitle
                    text:strQuestionTitle
                    wrapMode: Text.WordWrap
                    font.pixelSize: Theme.fontSizeMedium
                    font.letterSpacing: 2;
                    color: Theme.highlightColor
                    font.bold: true
                    horizontalAlignment: Text.AlignLeft
                    truncationMode: TruncationMode.Elide
                    anchors{
                        top:questionicon.top
                        left:questionicon.right
                        right:parent.right
                        margins: Theme.paddingMedium
                    }
                }
                Label{
                    id:questionContent
                    text:strQuestionContent
                    wrapMode: Text.WordWrap
                    font.pixelSize:Theme.fontSizeSmall
                    font.letterSpacing: 2;
                    anchors{
                        left:parent.left;
                        leftMargin: Theme.paddingMedium
                        right: parent.right;
                        top:questionTitle.bottom
                        margins: Theme.paddingMedium
                    }
                }
                Image {
                    id:answericon
                    enabled: opacity === 1.0
                    source: "image://theme/icon-m-tabs"
                    width: Theme.iconSizeMedium ;
                    height: Theme.iconSizeMedium;
                    anchors{
                        top:questionContent.bottom
                        left:parent.left
                        margins: Theme.paddingMedium
                        topMargin: Theme.paddingMedium*2;
                    }
                    Label {
                        anchors {
                            centerIn: parent
                        }
                        font.pixelSize: Theme.fontSizeExtraSmall
                        font.bold: true
                        color: Theme.highlightColor;
                        horizontalAlignment: Text.AlignHCenter
                        text:"A"
                    }
                }
                Label{
                    id:answerTitle
                    text:strAnswerTitle
                    wrapMode: Text.WordWrap
                    width: parent.width
                    font.pixelSize: Theme.fontSizeMedium
                    font.letterSpacing: 2;
                    color: Theme.highlightColor
                    font.bold: true
                    horizontalAlignment: Text.AlignLeft
                    truncationMode: TruncationMode.Elide
                    anchors{
                        left:answericon.right
                        right:parent.right
                        top:answericon.top
                        margins: Theme.paddingMedium
                    }
                }
                Label{
                    id:answerContent
                    text:strAnswerContent
                    wrapMode: Text.WordWrap
                    font.pixelSize:Theme.fontSizeSmall
                    font.letterSpacing: 2;
                    //color: Theme.highlightColor
                    anchors{
                        left:parent.left
                        right:parent.right
                        top:answerTitle.bottom
                        margins: Theme.paddingMedium
                    }

                }

            }

        }
