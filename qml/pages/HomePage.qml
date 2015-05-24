import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.4
import "getHpinfo.js" as Script
import "md5.js" as MD5
Item {
    id: homePage;
    height: mainView.height; width: mainView.width
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
                        Script.getBeforeDate(today,Math.abs(9-value))
                    }

                }
                Button{
                    id:gobutton
                    text:qsTr("GO")
                    anchors.top: dateslider.bottom
                    onClicked: {
                        allindex = Math.abs(dateslider.value -9);
                        pageStack.replace(Qt.resolvedUrl("MainPage.qml"))

                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }

        PullDownMenu{
            id:pushUp
            MenuItem{
                text:qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
        }
        Component.onCompleted: {
            Script.load(allindex)
            Script.tmp_index=allindex;
            listview.model = homeModel;

        }

        ListModel {
            id: homeModel;
        }

        model:homeModel
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
                text:strHpTitle
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
                            call('main.cacheImg',[strThumbnailUrl,MD5.hex_md5(strThumbnailUrl)],function(result){
                                 thumbnail.source = result;
                                 waitingIcon.visible = false;
                                console.log("local path:"+result)
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
                                                "strThumbnailUrl":strThumbnailUrl,
                                                "strHpTitle":strHpTitle} );
                           }
                    onPressAndHold: {
                        py.saveImg(MD5.hex_md5(strThumbnailUrl),strHpTitle+"."+Script.getBeforeDate(new Date(),Math.abs(allindex))+".jpg");

                    }
                }


            }
            Label{
                id:author
                text:imgName+"\n"+authorName
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
                        text:time_day

                    }
                    Label{
                        id:datetime2
                        anchors{
                            top:datetime.bottom
                        }
                        font.pixelSize:Theme.fontSizeExtraSmall
                        color: Theme.secondaryColor
                        opacity: 0.8
                        text:time_month_year
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
                    height: contentExt.height + content .height+Theme.paddingMedium*3
                    anchors{
                        left: date_lab.right;
                        right: parent.right;
                        margins: Theme.paddingMedium
                    }
                    radius: 5;
                    color: "#1affffff"
                    Label{
                        id:content
                        text:contentStr
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
                    }
                    Label{
                        id:contentExt
                        text:contentFrom
                        width:parent.width
                        wrapMode: Text.WordWrap
                        font.pixelSize:Theme.fontSizeSmall
                        horizontalAlignment: Text.AlignRight
                        anchors{
                            top:content.bottom
                            left:parent.left
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
