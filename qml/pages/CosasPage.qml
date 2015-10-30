import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3
import "md5.js" as MD5
Item {
    id: cosasPage;
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
            title:qsTr("Object")
        }
        width: parent.width
        //clip:true

        contentHeight: date_time.height + thumbnail.height + questionTitle.height+
                               questionContent.height+
                               hearer.height + Theme.paddingLarge * 4
                VerticalScrollDecorator {}
                Label{
                    id:date_time
                    text:objects.dom+","+objects.may
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

                Image{
                    id:thumbnail
                    asynchronous: true
                    fillMode: Image.PreserveAspectFit;
                    width:  parent.width - Theme.paddingMedium*2
                    Python{
                        id:imgpy
                         Component.onCompleted: {
                         addImportPath(Qt.resolvedUrl('./py')); // adds import path to the directory of the Python script
                         imgpy.importModule('main', function () {
                                call('main.cacheImg',[objects.cosas_imagen,MD5.hex_md5(objects.cosas_imagen)],function(result){
                                     thumbnail.source = result;
                                     waitingIcon.visible = false;

                                });
                       })
                      }
                    }
                    Image{
                        id:waitingIcon
                        anchors.centerIn: parent
                        fillMode: Image.PreserveAspectFit
                        source: "image://theme/icon-m-refresh";
                        //visible: parent.status==Image.Loading
                    }
                    anchors{
                        top: date_time.bottom;
                        topMargin: Theme.paddingLarge
                        horizontalCenter: parent.horizontalCenter
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            pageStack.push(Qt.resolvedUrl("ImagePage.qml"),
                                                  {"imgUrl": thumbnail.source,
                                                    "strThumbnailUrl":objects.cosas_imagen,
                                                    "strHpTitle":objects.cosas_titulo} );
                               }
                        onPressAndHold: {
                            py.saveImg(MD5.hex_md5(objects.cosas_imagen),objects.cosas_titulo+"."+Script.getBeforeDate(new Date(),Math.abs(allindex))+".jpg");

                        }
                    }


                }
                Label{
                    id:questionTitle
                    text:objects.cosas_titulo
                    wrapMode: Text.WordWrap
                    width: parent.width - Theme.paddingMedium
                    font.pixelSize: Theme.fontSizeMedium
                    font.letterSpacing: 2;
                    color: Theme.highlightColor
                    font.bold: true
                    horizontalAlignment: Text.AlignRight
                    truncationMode: TruncationMode.Elide
                    anchors{
                        top:thumbnail.bottom
                        right:parent.right
                        margins: Theme.paddingLarge
                    }
                }
                Label{
                    id:questionContent
                    text:objects.cosas_contenido
                    wrapMode: Text.WordWrap
                    width: parent.width
                    font.pixelSize:Theme.fontSizeSmall
                    font.letterSpacing: 2;
                    anchors{
                        left:parent.left;
                        top:questionTitle.bottom
                        margins: Theme.paddingMedium
                    }
                }



            }

        }
