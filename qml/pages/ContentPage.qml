import QtQuick 2.0
import Sailfish.Silica 1.0
import "getOneContentInfo.js" as Script

Page {
    id: homePage;
    //allowedOrientations: Orientation.Portrait | Orientation.Landscape
    onStatusChanged: {
        if (status == PageStatus.Active) {
            if (pageStack._currentContainer.attachedContainer == null) {
                pageStack.pushAttached(Qt.resolvedUrl("QuestionPage.qml"))
            }
        }
    }
    SilicaListView{
            id:listview
            anchors.fill: parent
            header: PageHeader{
                id:hearer
                title:qsTr("Content")
            }
            Component.onCompleted: {
                Script.load(allindex)
            }

            ListModel {
                id: contentModel;
            }

            model:contentModel
            width: parent.width
            clip:true
            spacing:Theme.paddingMedium
            cacheBuffer:parent.width
            VerticalScrollDecorator {}
            delegate: Item{
                width: parent.width
                height:gw.height + conttile.height + author.height + content.height + authorinfo.height + Theme.paddingMedium * 4
                Label{
                    id:gw
                    text:'" '+sGW+' "'
                    font.pixelSize: Theme.fontSizeExtraSmall/4*3
                    color: Theme.highlightColor
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    width:parent.width - Theme.paddingLarge
                    anchors.horizontalCenter: parent.horizontalCenter

                }

                Label{
                    id:conttile
                    text:strContTitle
                    width: parent.width
                    font.pixelSize: Theme.fontSizeLarge
                    color: Theme.highlightColor
                    font.bold: true
                    horizontalAlignment: Text.AlignLeft
                    wrapMode: Text.WordWrap
                    truncationMode: TruncationMode.Elide
                    anchors{
                        left:parent.left
                        top:gw.bottom
                        margins: Theme.paddingMedium
                    }
                }
                Label{
                    id:author
                    text:qsTr("Author/")+strContAuthor
                    font.bold: true
                    font.pixelSize:Theme.fontSizeSmall
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignRight
                    anchors{
                        left:parent.left
                        top:conttile.bottom
                        margins: Theme.paddingMedium
                    }
                }
                Label{
                    id:content
                    text:strContent
                    font.pixelSize:Theme.fontSizeSmall
                    width:parent.width
                    wrapMode: Text.WordWrap
                    anchors{
                        left:parent.left
                        right:parent.right
                        top:author.bottom
                        margins: Theme.paddingMedium
                    }
                }
                Label{
                    id:authorinfo
                    text:sAuth
                    font.pixelSize:Theme.fontSizeSmall
                    wrapMode: Text.WordWrap
                    font.bold: true
                    anchors{
                        left:parent.left
                        right:parent.right
                        top:content.bottom
                        margins: Theme.paddingMedium
                    }
                }

            }

        }

}
