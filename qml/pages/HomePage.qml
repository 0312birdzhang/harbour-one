import QtQuick 2.0
import Sailfish.Silica 1.0
import "getHpinfo.js" as Script

Page {
    id: homePage;
    //allowedOrientations: Orientation.Portrait | Orientation.Landscape
    onStatusChanged: {
        if (status == PageStatus.Active) {
            if (pageStack._currentContainer.attachedContainer == null) {
                pageStack.pushAttached(Qt.resolvedUrl("ContentPage.qml"))
            }
        }
    }
    Component.onCompleted: {
        if(allindex === 0 && num === 0){
            splash.visible = true;
            timerDisplay.start();
        }
    }

    SilicaListView{
            id:listview
            visible: false
            anchors.fill: parent
            header:PageHeader{
                id:hearer
                title:qsTr("Index")
            }

            PushUpMenu{
                id:upmenu
                MenuItem{
                    id: selectDate
                    //onYChanged: console.log("Y:"+selectDate.y)
                    width:  parent.width
                    height: (Theme.itemSizeLarge > gobutton.height)?Theme.itemSizeLarge:gobutton.height
                    Slider{
                        id:datepicker
                        value: 0
                        minimumValue:-9
                        maximumValue:0
                        stepSize: 1
                        width: parent.width - gobutton.width
                        valueText: {
                            var today = new Date();
                            Script.getBeforeDate(today,Math.abs(value))
                        }

                    }
                    Button{
                        id:gobutton
                        text:qsTr("GO")
                        anchors.left: datepicker.right
                        onClicked: {
                            //console.log("Index:"+Math.abs(datepicker.value));
                            allindex = Math.abs(datepicker.value);
                            num+=1;
                            //selectDate.open = !selectDate.open
                            //Script.load(allindex)
                            pageStack.replace(Qt.resolvedUrl("HomePage.qml"))

                        }

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: Theme.paddingSmall
                    }
                }

            }
            PullDownMenu {
                id:menu
                MenuItem{
                    text:qsTr("About")
                    onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
                }
            }


            Component.onCompleted: {
                Script.load(allindex)
                listview.model = homeModel;
            }

            ListModel {
                id: homeModel;
            }

            //model:homeModel
            width: parent.width
            clip:true
            cacheBuffer:parent.height
            spacing:Theme.paddingMedium
            VerticalScrollDecorator {}
            delegate: Item{
                width: parent.width
                CacheImage{
                    id:thumbnail
                    asynchronous: true
                    sourceUncached: strThumbnailUrl
                    fillMode: Image.PreserveAspectFit;
                    width:  parent.width - Theme.paddingSmall
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: parent.width *3/4
                    source: strThumbnailUrl
                    MouseArea {
                        anchors.fill: parent
                        onClicked: pageStack.push(Qt.resolvedUrl("ImagePage.qml"),
                                                         {imgUrl: strThumbnailUrl} )
                    }

                }
                Label{
                    id:author
                    text:strAuthor
                    font.pixelSize:Theme.fontSizeMedium
                    width: parent.width
                    wrapMode: Text.WordWrap
                    color: Theme.highlightColor
                    horizontalAlignment: Text.AlignRight
                    anchors{
                        left:parent.left
                        right:parent.right
                        top:thumbnail.bottom
                        margins: Theme.paddingMedium
                    }
                }
                Label{
                    id:vol
                    text:strHpTitle
                    //width: parent.width
                    font.pixelSize: Theme.fontSizeLarge
                    color: Theme.highlightColor
                    font.bold: true
                    horizontalAlignment: Text.AlignLeft
                    truncationMode: TruncationMode.Elide
                    anchors{
                        left:parent.left
                        right:parent.right
                        top:author.bottom
                        margins: Theme.paddingMedium
                    }
                }


                    Item {
                        id:input
                        anchors{
                            top:author.bottom
                            margins: Theme.paddingMedium
                        }
                        width:parent.width
                        height: datetime.height + content .height
                        Label{
                            id:datetime
                            text:strMarketTime.substring(5,10)
                            font.pixelSize:Theme.fontSizeLarge
                            color: Theme.highlightColor
                            anchors{
                                top:parent.top
                                right:parent.right
                                rightMargin: Theme.paddingMedium
                            }
                        }

                        Label{
                            id:content
                            text:strContent
                            width:parent.width
                            wrapMode: Text.WordWrap
                            anchors{
                                top:datetime.bottom
                                left:parent.left
                                right:parent.right
                                margins: Theme.paddingMedium
                            }


                        }
                    }

            }

        }


    Image {
        id: splash
        visible: false
        anchors.fill: parent;
        source: "pics/splash.png"
        fillMode: Image.PreserveAspectCrop
        clip: true
        NumberAnimation on opacity {duration: 500}
    }
    Timer {
        id: timerDisplay
        running: true; repeat: false; triggeredOnStart: false
        interval: 2 * 1000

        onTriggered: {
            splash.visible = false
            listview.visible = true
        }
    }
}
