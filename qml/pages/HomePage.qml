import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3
import "storage.js" as Storage
import "getBeforeDate.js" as GetDate

Item {
    id: homePage;

    height: mainView.height; 
    width: mainView.width;
    property string home_summary: fmtHtml(objects["entries"][0].summary);
    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: !PageStatus.Active
        size: BusyIndicatorSize.Large
    }

    function getHomeImage(){
        return getImagen(home_summary);
    }

    function getLeyenda(){
        var regex = /<div class=\"one-imagen-leyenda\">(.*?)<br/g;
        return regex.exec(home_summary)[1];
    }

    function getdom(){
        var regex = /<p class=\"dom\">(.*?)<\/p>/g;
        var dom = regex.exec(home_summary)[1];
        return dom;
    }

    function getmay(){
        var regex = /<p class=\"may\">(.*?)<\/p>/g;
        return regex.exec(home_summary)[1];
    }

    function getcita(){
        var regex = /<div class=\"one-cita\">(.*?)<\/div>/g;
        return regex.exec(home_summary)[1];
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
            enabled: false
            Item{
                width:  parent.width
                height: Theme.itemSizeExtraLarge +gobutton.height
                Slider{
                    id:dateslider
                    value: 7-allindex
                    minimumValue:0
                    maximumValue:7
                    stepSize: 1
                    width: parent.width
                    valueText: {
                        var today = new Date();
                        GetDate.getBeforeDate(today,Math.abs(7-value))
                    }

                }
                Row{
                    anchors.top: dateslider.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: Theme.paddingLarge
                    Button{
                        id:gobutton
                        text:qsTr("GO")
                         //anchors.top: parent.top
                        onClicked: {
                            allindex = Math.abs(dateslider.value -7);
                            currentDay = new Date(dateslider.valueText)
                            py.getDatas((dateslider.valueText).replace(/-/g,''))

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
                id: vol
                text: getVOL(objects["entries"][0].summary)
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
                id: thumbnail
                asynchronous: true
                fillMode: Image.PreserveAspectFit;
                width:  parent.width - Theme.paddingMedium*2
                property string originurl: getHomeImage();
                Python{
                    id:imgpy
                     Component.onCompleted: {
                        addImportPath(Qt.resolvedUrl('./py')); // adds import path to the directory of the Python script
                        imgpy.importModule('main', function () {
                            call('main.cacheImg',[thumbnail.originurl],function(result){
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
                                                "strThumbnailUrl":thumbnail.originurl,
                                                "strHpTitle":author.text} );
                           }
                    onPressAndHold: {
                        py.saveImg(thumbnail.originurl, GetDate.parseDate(currentDay));
                    }
                }


            }
            Label{
                id:author
                text: getLeyenda()
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
                        text: getdom()

                    }
                    Label{
                        id:datetime2
                        anchors{
                            top:datetime.bottom
                        }
                        font.pixelSize:Theme.fontSizeExtraSmall
                        color: Theme.secondaryColor
                        opacity: 0.8
                        text: getmay()
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
                    height: content.height + Theme.paddingMedium*4
                    anchors{
                        left: date_lab.right;
                        right: parent.right;
                        margins: Theme.paddingMedium
                    }
                    radius: 5;
                    color: "#1affffff"
                    Label{
                        id:content
                        text:getcita()
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
                                Clipboard.text = content.text;
                                addNotification(qsTr("Copyed to clipboard"));
                            }
                        }
                    }
                    // Label{
                    //     id:contentExt
                    //     text:objects.cita_author
                    //     width:parent.width
                    //     wrapMode: Text.WordWrap
                    //     font.pixelSize:Theme.fontSizeSmall
                    //     horizontalAlignment: Text.AlignRight
                    //     anchors{
                    //         top:content.bottom
                    //         right:parent.right
                    //         margins: Theme.paddingMedium
                    //     }
                    // }

                }
            }

            Item{
                height:Theme.paddingLarge * 3
            }

        }

    }
}
