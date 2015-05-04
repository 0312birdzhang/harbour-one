import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: aboutPage;
    //allowedOrientations: Orientation.Portrait | Orientation.Landscape



    SilicaFlickable {
        anchors.fill: parent
        PageHeader{
            id:header
            title:qsTr("About")
        }

        clip: true;
        contentWidth: width;
        contentHeight: contentCol.height;

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
                wrapMode: Text.WordWrap
                width:parent.width
                anchors.margins: Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter
                text:"Version 0.1-3"

            }
            Item { width: 1; height: 1 }
            Label{
                id:author
                wrapMode: Text.WordWrap
                width:parent.width
                anchors.margins: Theme.paddingLarge
                horizontalAlignment: Text.AlignLeft
                text:"「ONE一个」每天只为你准备一张图片、一篇文字和一个问答"

            }
            Item { width: 1; height: 1 }
            Label{
                id:copyright
                text:"本软件是one一个非官网客户端版本，作者:0312birdzhang"
                width:parent.width - Theme.paddingLarge
                wrapMode: Text.WordWrap
                anchors.margins: Theme.paddingLarge
            }
            Item { width: 1; height: 1 }
            Label{
                id:donate
                wrapMode: Text.WordWrap
                anchors.margins: Theme.paddingLarge
                horizontalAlignment: Text.Alignleft
                width:parent.width - Theme.paddingLarge
                text:"由于API限制，只能查看10天的内容，感谢夜切整理的API。如果你觉得此软件你有所益处，你可以选择捐赠本人。当然，本软件是完全"
                    +"免费的，你可以尽情使用。<br/>"+
                     "我的支付宝账号:18520399451<br/>Donations are welcome :)"

            }


        }
    }
}
