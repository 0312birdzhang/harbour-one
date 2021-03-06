import QtQuick 2.0
import Sailfish.Silica 1.0


Item {
    id: questionPage;
    height: mainView.height; width: mainView.width
    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: !PageStatus.Active
        size: BusyIndicatorSize.Large
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
        contentHeight: questionTitle.height + answerContent.height +Theme.paddingLarge * 4
        VerticalScrollDecorator {}

        Label{
            id:questionTitle
            text:objects.entries[2].title
            wrapMode: Text.WordWrap
            font.pixelSize: Theme.fontSizeMedium
            font.letterSpacing: 2;
            color: Theme.highlightColor
            font.bold: true
            horizontalAlignment: Text.AlignLeft
            truncationMode: TruncationMode.Elide
            anchors{
                top:hearer.bottom
                left:parent.right
                right:parent.right
                margins: Theme.paddingMedium
            }
        }
        // Label{
        //     id:questionContent
        //     text:objects.cuestion_question
        //     wrapMode: Text.WordWrap
        //     font.pixelSize:Theme.fontSizeSmall
        //     font.letterSpacing: 2;
        //     anchors{
        //         left:parent.left;
        //         leftMargin: Theme.paddingMedium
        //         right: parent.right;
        //         top:questionTitle.bottom
        //         margins: Theme.paddingMedium
        //     }
        // }
        // Image {
        //     id:answericon
        //     enabled: opacity === 1.0
        //     source: "image://theme/icon-m-tabs"
        //     width: Theme.iconSizeMedium ;
        //     height: Theme.iconSizeMedium;
        //     anchors{
        //         top:questionContent.bottom
        //         left:parent.left
        //         margins: Theme.paddingMedium
        //         topMargin: Theme.paddingMedium*2;
        //     }
        //     Label {
        //         anchors {
        //             centerIn: parent
        //         }
        //         font.pixelSize: Theme.fontSizeExtraSmall
        //         font.bold: true
        //         color: Theme.highlightColor;
        //         horizontalAlignment: Text.AlignHCenter
        //         text:"A"
        //     }
        // }
        // Label{
        //     id:answerTitle
        //     text:objects.cuestion_answerer
        //     wrapMode: Text.WordWrap
        //     width: parent.width
        //     font.pixelSize: Theme.fontSizeMedium
        //     font.letterSpacing: 2;
        //     color: Theme.highlightColor
        //     font.bold: true
        //     horizontalAlignment: Text.AlignLeft
        //     truncationMode: TruncationMode.Elide
        //     anchors{
        //         left:answericon.right
        //         right:parent.right
        //         top:answericon.top
        //         margins: Theme.paddingMedium
        //     }
        // }
        Label{
            id:answerContent
            text: fmtHtml(objects.entries[2].summary)
            wrapMode: Text.WordWrap
            font.pixelSize:Theme.fontSizeSmall
            textFormat: Text.RichText
            font.letterSpacing: 2;
            anchors{
                left:parent.left;
                leftMargin: Theme.paddingMedium
                right: parent.right;
                top:questionTitle.bottom
                margins: Theme.paddingMedium
            }

        }

    }

}
