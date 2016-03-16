import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3
import "storage.js" as Storage
import "md5.js" as MD5
import "getBeforeDate.js" as GetDate

Item {
    id: homePage;

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
        header:PageHeader{
            id:hearer
            title:qsTr("Index")
        }

        PushUpMenu {
            id:menu
            Item{
                width:  parent.width
                height: Theme.itemSizeExtraLarge +gobutton.height
                Slider{
                    id:dateslider
                    value: 9-allindex
                    minimumValue:0
                    maximumValue:9
                    stepSize: 1
                    width: parent.width
                    valueText: {
                        var today = new Date();
                        GetDate.getBeforeDate(today,Math.abs(9-value))
                    }

                }
                Row{
                    anchors.top: dateslider.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: Theme.paddingLarge
//                    Button{
//                        id:selectMore
//                        text:qsTr("See More")

//                        function openDateDialog() {
//                            var dialog = pageStack.push("Sailfish.Silica.DatePickerDialog", {
//                                            date: GetDate.getBeforeDate(new Date(),10)
//                                         })

//                            dialog.accepted.connect(function() {
//                                var date = dialog.date;
//                                currentDay = date;
//                                var day =GetDate.parseDate(date)
//                                py.getDatas(day)
//                            })
//                        }
//                        onClicked: openDateDialog()
//                    }

                    Button{
                        id:gobutton
                        text:qsTr("GO")
                         //anchors.top: parent.top
                        onClicked: {
                            allindex = Math.abs(dateslider.value -9);
                            currentDay = new Date(dateslider.valueText)

                            //var volnum =GetDate.getDiffDay3(dateslider.valueText)
                            //busyIndicator.running = true
                            py.getDatas(dateslider.valueText)

                        }
                       //anchors.horizontalCenter: parent.horizontalCenter
                    }
              }
            }
        }

        PullDownMenu{
            id:pushUp
            MenuItem{
                text:qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
//            MenuItem{
//                text:qsTr("Favorites")
//                onClicked: pageStack.push(Qt.resolvedUrl("FavoritePage.qml"))
//            }

//            MenuItem{
//                text:qsTr("Add to favorite")
//                onClicked:{
//                    var day = GetDate.parseDate(currentDay)
//                    if(Storage.addFavorite(day,objects.titulo)){
//                        addNotification(qsTr("Add to favorite success "))
//                    }else{
//                        addNotification(qsTr("Add to favorite failed"))
//                    }
//                }
//            }
        }


        model:1
        width: parent.width
        clip:true
        cacheBuffer:parent.width
        spacing:Theme.paddingMedium
        VerticalScrollDecorator {}
        delegate: Item{
            width: parent.width
            height: vol.implicitHeight +thumbnail.height
                    + author.height + dateAndcontent.height + Theme.paddingMedium * 10
                    + Theme.paddingLarge *2
            Label{
                id:vol
                text:objects.titulo
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
                            call('main.cacheImg',[objects.imagen,MD5.hex_md5(objects.imagen)],function(result){
                                 thumbnail.source = result;
                                 waitingIcon.visible = false;
                                //console.log("local path:"+result)
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
                    top: vol.bottom;
                    topMargin: Theme.paddingLarge
                    horizontalCenter: parent.horizontalCenter
                }
                height: parent.width *3/4
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("ImagePage.qml"),
                                              {"imgUrl": thumbnail.source,
                                                "strThumbnailUrl":objects.imagen,
                                                "strHpTitle":objects.imagen_leyenda} );
                           }
                    onPressAndHold: {
                        py.saveImg(MD5.hex_md5(objects.imagen),objects.imagen_leyenda+"."+GetDate.parseDate(currentDay));

                    }
                }


            }
            Label{
                id:author
                text:objects.imagen_leyenda
                width: parent.width
                wrapMode: Text.WordWrap
                font.pixelSize:Theme.fontSizeExtraSmall
                color: Theme.secondaryColor
                horizontalAlignment: Text.AlignRight
                anchors{
                    left:parent.left
                    right:parent.right
                    top:thumbnail.bottom
                    margins: Theme.paddingMedium
                }
            }

            Item{
                id:dateAndcontent
                width: parent.width;
                height:input.height > date_lab.height ? input.height: date_lab.height
                anchors{
                    top:author.bottom
                    topMargin: Theme.paddingLarge
                    leftMargin: Theme.paddingMedium
                    rightMargin: Theme.paddingMedium
                }
                Item {
                    id:date_lab
                    width:datetime2.implicitWidth
                    height: datetime.implicitHeight+datetime2.implicitHeight;
                    anchors{
                        left:parent.left;
                        leftMargin:Theme.paddingMedium
                        rightMargin:Theme.paddingLarge
                    }

                    Label{
                        id:datetime
                        anchors{
                            top:parent.top
                            right:parent.right
                        }
                        width: parent.width;
                        height: implicitHeight;
                        font.pixelSize:parent.width;
                        font.bold: true
                        color: Theme.highlightColor
                        horizontalAlignment: Text.AlignHCenter
                        text:objects.dom

                    }
                    Label{
                        id:datetime2
                        anchors{
                            top:datetime.bottom
                        }
                        font.pixelSize:Theme.fontSizeExtraSmall
                        color: Theme.secondaryColor
                        opacity: 0.8
                        text:objects.may
                    }
                }
                Image {
                    anchors{
                        top:date_lab.top
                        topMargin: date_lab.height/3;
                        right: input.left;
                    }
                    source: "pics/info.png"
                    opacity: 0.1
                }
                Rectangle {
                    id:input
                    //width:parent.width-datetime2.implicitWidth
                    height: contentExt.height + content .height+Theme.paddingMedium*4
                    anchors{
                        left: date_lab.right;
                        right: parent.right;
                        margins: Theme.paddingMedium
                    }
                    radius: 5;
                    color: "#1affffff"
                    Label{
                        id:content
                        text:objects.cita_content
                        width:parent.width
                        wrapMode: Text.WordWrap
                        font.letterSpacing: 2;
                        font.pixelSize:Theme.fontSizeMedium
                        color: Theme.highlightColor
                        anchors{
                            top:parent.top
                            left:parent.left
                            right:parent.right
                            margins: Theme.paddingMedium
                        }
                        MouseArea{
                            anchors.fill: parent
                            onPressAndHold: {
                                Clipboard.text = objects.cita_content;
                                addNotification(qsTr("Copyed to clipboard"));
                            }
                        }
                    }
                    Label{
                        id:contentExt
                        text:objects.cita_author
                        width:parent.width
                        wrapMode: Text.WordWrap
                        font.pixelSize:Theme.fontSizeSmall
                        horizontalAlignment: Text.AlignRight
                        anchors{
                            top:content.bottom
                            right:parent.right
                            margins: Theme.paddingMedium
                        }
                    }

                }
            }

            Item{
                height:Theme.paddingLarge * 3
            }

        }

    }
}
