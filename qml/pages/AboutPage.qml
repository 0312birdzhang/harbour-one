import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: aboutPage;
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
                source:"pics/welcome_image_2.png"
                anchors.horizontalCenter: parent.horizontalCenter;
            }

            Item { width: 1; height: 1 }
            Label{
                id:version
                width:parent.width
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                text:qsTr("Version")+" 0.8-1"

            }
            Item{width:1;height:1}
            LabelText {
                label: qsTr("About")
                text: "「ONE一个」每天只为你准备一张图片、一篇文字和一个问答"
            }
            Item{width:1;height:1}
            LabelText {
                label: qsTr("Author")
                text: "本软件是one一个非官网客户端版本,作者:0312birdzhang,，旧版API由 夜切 整理(现在已不用API方式获取)，软件桌面图标由 梦影决幻 设计,软件启动图、部分UI由 蝉曦 设计"

            }
            Item{width:1;height:1}
            LabelText {
                label: qsTr("Guide")
                text: "在首页长按图片或者查看图片大图点击右下角的下载按钮都可以将图片保存到Pictures/save/One/目录下；长按首页文字可以复制,左右滑动切换每天为你准备的图片、文字、问答;"+
                       "点击收藏夹内容可以查看已经收藏过的."

            }
            Item{width:1;height:1}
            LabelText {
                label: qsTr("Donation")
                text:"通过‘查看更多’可以从第一期到现在的都可以查看。如果你觉得此软件你有所益处，你可以选择捐赠我。当然，本软件是完全"
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
