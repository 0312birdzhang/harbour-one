import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: aboutPage;
    allowedOrientations: Orientation.Portrait | Orientation.Landscape
    SilicaFlickable {
        anchors.fill: parent
        PageHeader{
            id:header
            title:qsTr("About")
        }

        clip: true;
        contentWidth: width;
        contentHeight: contentCol.height + Theme.paddingLarge * 5
        RemorsePopup {
            id: remorse
        }
        Column {
            id: contentCol;
            anchors {
                left: parent.left;
                right: parent.right;
                margins: Theme.paddingSmall;
                top:header.bottom
            }
            spacing: Theme.paddingLarge;
            Item { width: 1; height: 1 }

            Image{
                id:logo
                fillMode: Image.Stretch;
                source:"pics/one_title.png"
                anchors.horizontalCenter: parent.horizontalCenter;
            }

            Item { width: 1; height: 1 }
            Label{
                id:version
                width:parent.width
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                text:qsTr("Version")+" 0.4-2"

            }
            Item { width: 1; height: 1 }
            Label{
                id:author
                wrapMode: Text.WordWrap
                width:parent.width
                anchors.margins: Theme.paddingLarge
                horizontalAlignment: Text.AlignHCenter
                text:"「ONE一个」每天只为你准备一张图片、一篇文字和一个问答"

            }
            Item { width: 1; height: 1 }
            Label{
                id:copyright
                text:"本软件是one一个非官网客户端版本,作者:0312birdzhang,，API由 夜切 整理，软件桌面图标由 梦影决幻 设计,软件启动图、界面由 蝉曦 设计，然而\
我只是打酱油的。 "
                width:parent.width
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                anchors.margins: Theme.paddingLarge
            }
            Item { width: 1; height: 1 }
            Label{
                id:donate
                wrapMode: Text.WordWrap
                anchors.margins: Theme.paddingLarge
                horizontalAlignment: Text.AlignHCenter
                width:parent.width
                text:"由于API限制，只能查看10天的内容。如果你觉得此软件你有所益处，你可以选择捐赠本人。当然，本软件是完全"
                    +"免费的，你可以尽情使用。<br/>"+
                     "  我的支付宝账号:18520399451 <br/> Donations are welcome :)"

            }
            Item{width:1;height:1}
            Button{
                id:clearButton
                text:qsTr("clear cache")
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    remorse.execute(qsTr("Begin clear cache..."),function(){
                        py.clearCache();
                    },3000);
                }
            }


        }
    }
}
