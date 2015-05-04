import QtQuick 2.0
import Sailfish.Silica 1.0
import "getOneQuestionInfo.js" as Script

Page {
    id: homePage;
    //allowedOrientations: Orientation.Portrait | Orientation.Landscape
    property var strQuestionTitle:""
    property var strQuestionContent:""
    property var strAnswerTitle:""
    property var strAnswerContent:""

    Component.onCompleted: {
        Script.load(allindex)
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

        contentHeight: questionRect.height + questionTitle.height+
                       questionContent.height+ answerRect.height +
                       answerTitle.height + answerContent.height +
                       hearer.height + Theme.paddingLarge * 4
        VerticalScrollDecorator {}
        Item{
            id:questionRect
            height:childrenRect.height
            anchors{
                top:hearer.bottom
                left:parent.left
                right:parent.right
            }
            Rectangle{
                width: questIcon.width + Theme.paddingMedium
                height: questIcon.height + Theme.paddingSmall
                anchors.horizontalCenter: parent.horizontalCenter
                border.color:Theme.highlightColor
                color:"#00000000"
                radius: 30
                Label{
                    id:questIcon
                    text:"  question"
                    font.pixelSize: Theme.fontSizeLarge
                }
            }

        }
        Label{
            id:questionTitle
            text:strQuestionTitle
            width: parent.width
            wrapMode: Text.WordWrap
            font.pixelSize: Theme.fontSizeLarge
            color: Theme.highlightColor
            font.bold: true
            horizontalAlignment: Text.AlignLeft
            truncationMode: TruncationMode.Elide
            anchors{
                left:parent.left
                right:parent.right
                top:questionRect.bottom
                margins: Theme.paddingMedium
            }
        }
        Label{
            id:questionContent
            text:strQuestionContent
            wrapMode: Text.WordWrap
            font.pixelSize:Theme.fontSizeSmall
            //color: Theme.highlightColor
            anchors{
                left:parent.left
                right:parent.right
                top:questionTitle.bottom
                margins: Theme.paddingMedium
            }



        }


        Item{
            id:answerRect
            height:childrenRect.height
            anchors{
                top:questionContent.bottom
                left:parent.left
                right:parent.right
                margins: Theme.paddingLarge
            }
            Rectangle{
                width: answerIcon.width + Theme.paddingMedium
                height: answerIcon.height + Theme.paddingSmall
                anchors.horizontalCenter: parent.horizontalCenter
                border.color:Theme.highlightColor
                color:"#00000000"
                radius: 30
                Label{
                    id:answerIcon
                    text:"  answer"
                    font.pixelSize: Theme.fontSizeLarge
                }

            }
        }
        Label{
            id:answerTitle
            text:strAnswerTitle
            wrapMode: Text.WordWrap
            width: parent.width
            font.pixelSize: Theme.fontSizeLarge
            color: Theme.highlightColor
            font.bold: true
            horizontalAlignment: Text.AlignLeft
            truncationMode: TruncationMode.Elide
            anchors{
                left:parent.left
                right:parent.right
                top:answerRect.bottom
                margins: Theme.paddingMedium
            }
        }
        Label{
            id:answerContent
            text:strAnswerContent
            wrapMode: Text.WordWrap
            font.pixelSize:Theme.fontSizeSmall
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
