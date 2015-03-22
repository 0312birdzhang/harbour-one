import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id: root

    property string imgUrl
    property real picscale: slider.value/100

    function calcscale(){
        return pic.sourceSize.height/pic.sourceSize.width < root.height/root.width
                ? root.width/pic.sourceSize.width
                : root.height/pic.sourceSize.height
    }

    onStatusChanged: {
        if (status == PageStatus.Active)
            pic.source = imgUrl
    }

    ToolButton {
        z: 10
        anchors {
            left: parent.left; bottom: parent.bottom;
            margins: platformStyle.paddingSmall;
        }
        iconSource: "toolbar-back"; onClicked: pageStack.pop()
        platformInverted: true;
    }

    Slider {
        id: slider
        z: 10
        anchors {
            horizontalCenter: parent.horizontalCenter;
            bottom: parent.bottom;
            bottomMargin: platformStyle.paddingSmall;
        }
        width: screen.width - 120
        minimumValue: 1;
        maximumValue: 200; stepSize: 2
        valueIndicatorVisible: true
        valueIndicatorText: slider.value  + "%"
        visible: Image.Ready == pic.status
        value: 100.0
    }

    Flickable {
        id: flic
        anchors.fill: parent

        property int oldContentWidth
        property int oldContentHeight

        contentWidth: Math.max(width, pic.width * pic.scale)+1
        contentHeight: Math.max(height, pic.height * pic.scale)+1

        onContentWidthChanged: {
            if(( flic.oldContentWidth != 0) && ( flic.width != 0) ){
                flic.contentX += (flic.contentWidth - flic.oldContentWidth)/2;
            }
            flic.oldContentWidth = flic.contentWidth;
        }
        onContentHeightChanged: {
            if((flic.oldContentHeight != 0) && ( flic.height != 0)) {
                flic.contentY += (flic.contentHeight - flic.oldContentHeight)/2;
            }
            flic.oldContentHeight = flic.contentHeight;
        }
        Image{
            id: pic
            anchors.centerIn: parent
            scale: root.picscale
            smooth: true
            onStatusChanged: {
                if(Image.Ready == pic.status){
                    slider.value = Math.floor(root.calcscale() * 100);
                    flic.contentX = 0; flic.contentY = 0;
                }
            }
            Column {
                anchors.centerIn: parent
                spacing: platformStyle.paddingLarge
                visible: pic.status == Image.Loading
                BusyIndicator {
                    anchors.horizontalCenter: parent.horizontalCenter
                    running: true
                    width: platformStyle.graphicSizeLarge
                    height: platformStyle.graphicSizeLarge
                    platformInverted: true
                }
                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: Math.floor(pic.progress * 100) + "%"
                    color: platformStyle.colorDisabledMidInverted
                    font.pixelSize: platformStyle.fontSizeLarge
                }
            }
        }
        PinchArea {
            property real oldScale
            anchors.fill: parent
            onPinchStarted: oldScale = slider.value
            onPinchUpdated: {
                slider.value = oldScale * pinch.scale
            }
        }
        MouseArea{
            anchors.fill: parent
            onDoubleClicked: {
                if (slider.value < 90){
                    slider.value = 100
                } else {
                    slider.value = Math.floor(root.calcscale() * 100);
                }
            }
        }
    }
}
