/*
    GPL V2
*/

import QtQuick 2.1
import Sailfish.Silica 1.0
import "getHpinfo.js" as Script

Page{
    id: mainPage
    allowedOrientations: Orientation.Portrait | Orientation.Landscape


    BusyIndicator {
        running: !PageStatus.Active
        size: BusyIndicatorSize.Large
        anchors.centerIn: parent
    }

    SlideshowView {
        id: mainView
        //itemWidth: width
        //itemHeight: height
        height: Screen.height
        width:Screen.width
        clip:true
        anchors.fill: parent
        model: VisualItemModel {
            HomePage {}
            ContentPage{}
            QuestionPage{}
        }
    }
    Rectangle {
        id: splash
        visible: false
        anchors.fill: parent;
        color: "#483D8B"
        Image {
            id:wel1
            anchors.horizontalCenter: parent.horizontalCenter
            y:parent.height/16*7-implicitHeight/2;
            source: "pics/welcome_image_1.png"
        }
        Image {
            id:wel2
            anchors.horizontalCenter: parent.horizontalCenter
            y:parent.height/4*3;
            source: "pics/welcome_image_2.png"
        }
        Image {
            id:wel3
            anchors.top: wel2.bottom;
            anchors.topMargin: Theme.paddingMedium
            anchors.horizontalCenter: parent.horizontalCenter
            source: "pics/welcome_image_name.png"
        }
        NumberAnimation on opacity {duration: 500}
    }
    Timer {
        id: timerDisplay
        running: true; repeat: false; triggeredOnStart: false
        interval: 1 * 1000
        onTriggered: {
            splash.visible = false;
        }
    }
    Component.onCompleted: {
        if(allindex === 0 && num === 0){
            splash.visible = true;
            timerDisplay.start();
        }
        num+=1;

    }

}
