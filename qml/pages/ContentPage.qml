import QtQuick 2.0
import Sailfish.Silica 1.0
import "getOneContentInfo.js" as Script

Item {
    id: contenPage;
    //allowedOrientations: Orientation.Portrait | Orientation.Landscape
    height: mainView.height; width: mainView.width
    SilicaListView{
            id:listview
            anchors.fill: parent
            header: PageHeader{
                id:hearer
                title:qsTr("Content")
            }
            Component.onCompleted: {
                Script.load(allindex)
                Script.tmp_index=allindex;

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
                            height:date_time.implicitHeight
                                   +gwrow.height
                                   + conttile.height
                                   + author.height
                                   + content.height
                                   + authorinfo.height
                                   + Theme.paddingMedium * 15
                            Label{
                                id:date_time
                                text:strMarketTime
                                color: Theme.secondaryColor
                                font.pixelSize:Theme.fontSizeExtraSmall
                                horizontalAlignment: Text.AlignLeft
                                truncationMode: TruncationMode.Elide
                                anchors{
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
                            Row{
                                id:gwrow
                                height: gw.implicitHeight;
                                anchors{
                                    top:date_time.bottom;
                                    topMargin: Theme.paddingLarge
                                    left:parent.left;
                                    leftMargin: Theme.paddingMedium
                                }

                                Image {
                                    id:sgwlab1
                                    anchors.top:parent.top;
                                    source:"pics/x_left.png"
                                }

                                Item{height: 5;width: Theme.paddingLarge;}

                                Label{
                                    id:gw
                                    text:sGW
                                    width: listview.width - Theme.paddingMedium*3-Theme.paddingLarge-sgwlab1.implicitWidth-sgwlab2.implicitWidth;
                                    font.pixelSize: Theme.fontSizeExtraSmall
                                    font.letterSpacing: 1;
                                    color: Theme.secondaryColor
                                    wrapMode: Text.WordWrap
                                    elide: Text.ElideMiddle
                                }

                                Item{height: 5;width: Theme.paddingMedium;}

                                Image {
                                    id:sgwlab2
                                    anchors.bottom:parent.bottom;
                                    source:"pics/x_right.png"
                                }
                            }



                            Label{
                                id:conttile
                                text:strContTitle
                                width: parent.width
                                font.pixelSize: Theme.fontSizeMedium
                                color: Theme.highlightColor
                                font.bold: true
                                horizontalAlignment: Text.AlignLeft
                                wrapMode: Text.WordWrap
                                truncationMode: TruncationMode.Elide
                                anchors{
                                    left:parent.left
                                    top:gwrow.bottom
                                    margins: Theme.paddingMedium
                                    topMargin: Theme.paddingMedium*2
                                }
                            }
                            Label{
                                id:author
                                text:"作者/"+strContAuthor+"\n"
                                font.bold: true
                                font.pixelSize:Theme.fontSizeExtraSmall
                                color: Theme.secondaryColor;
                                wrapMode: Text.WordWrap
                                horizontalAlignment: Text.AlignRight
                                anchors{
                                    left:parent.left
                                    leftMargin: Theme.paddingMedium
                                    top:conttile.bottom
                                    rightMargin: Theme.paddingMedium
                                    topMargin: Theme.paddingMedium
                                }
                                opacity: 0.6
                            }
                            Label{
                                id:content
                                text:strContent+strContAuthorIntroduce;
                                font.pixelSize:Theme.fontSizeSmall
                                width:parent.width
                                wrapMode: Text.WordWrap
                                font.letterSpacing: 2;
                                anchors{
                                    left:parent.left
                                    right:parent.right
                                    top:author.bottom
                                    margins: Theme.paddingMedium
                                    topMargin: Theme.paddingMedium*2
                                }
                            }
                            Label{
                                id:authorinfo
                                text:sAuth
                                font.pixelSize:Theme.fontSizeExtraSmall
                                wrapMode: Text.WordWrap
                                color: Theme.secondaryColor
                                anchors{
                                    left:parent.left
                                    right:parent.right
                                    top:content.bottom
                                    topMargin: Theme.paddingLarge * 3
                                    margins: Theme.paddingMedium
                                }
                            }

                        }

                    }

         }
