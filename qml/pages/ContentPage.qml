import QtQuick 2.0
import Sailfish.Silica 1.0


Item {
    id: contenPage;
    //allowedOrientations: Orientation.Portrait | Orientation.Landscape
    height: mainView.height; width: mainView.width
    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: !PageStatus.Active
        size: BusyIndicatorSize.Large
    }
    SilicaListView{
            id:listview
            anchors.fill: parent
            header: PageHeader{
                id:hearer
                title:qsTr("Content")
            }
            model:1
            width: parent.width
            clip:true
            spacing:Theme.paddingMedium
            cacheBuffer:parent.width
            VerticalScrollDecorator {}
            delegate: Item{
                            width: parent.width
                            height: conttile.height + content.height + Theme.paddingLarge * 2
                            Label{
                                id:conttile
                                text:objects.entries[1].title
                                width: parent.width
                                font.pixelSize: Theme.fontSizeMedium
                                color: Theme.highlightColor
                                font.bold: true
                                horizontalAlignment: Text.AlignLeft
                                wrapMode: Text.WordWrap
                                truncationMode: TruncationMode.Elide
                                anchors{
                                    left:parent.left
                                    top:parent.top
                                    margins: Theme.paddingMedium
                                    topMargin: Theme.paddingMedium*2
                                }
                            }
                            // Label{
                            //     id:author
                            //     text:objects.articulo_autor
                            //     font.bold: true
                            //     font.pixelSize:Theme.fontSizeExtraSmall
                            //     color: Theme.secondaryColor;
                            //     wrapMode: Text.WordWrap
                            //     horizontalAlignment: Text.AlignRight
                            //     anchors{
                            //         left:parent.left
                            //         leftMargin: Theme.paddingMedium
                            //         top:conttile.bottom
                            //         rightMargin: Theme.paddingMedium
                            //         topMargin: Theme.paddingMedium
                            //     }
                            //     opacity: 0.6
                            // }
                            Label{
                                id:content
                                text: fmtHtml(objects.entries[1].summary)
                                font.pixelSize:Theme.fontSizeSmall
                                width:parent.width
                                textFormat: Text.RichText
                                wrapMode: Text.WordWrap

                                font.letterSpacing: 2;
                                anchors{
                                    left:parent.left
                                    right:parent.right
                                    top:conttile.bottom
                                    margins: Theme.paddingMedium
                                    topMargin: Theme.paddingMedium*2
                                }
                            }
                            // Label{
                            //     id:authorinfo
                            //     text:objects.articulo_editor
                            //     font.pixelSize:Theme.fontSizeExtraSmall
                            //     wrapMode: Text.WordWrap
                            //     color: Theme.secondaryColor
                            //     anchors{
                            //         left:parent.left
                            //         right:parent.right
                            //         top:content.bottom
                            //         topMargin: Theme.paddingLarge * 3
                            //         margins: Theme.paddingMedium
                            //     }
                            // }

                        }

                    }

         }
