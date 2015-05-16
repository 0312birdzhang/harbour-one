/*
The MIT License (MIT)

Copyright (c) 2014 Steffen Förster

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

import QtQuick 2.1
import Sailfish.Silica 1.0
import "getHpinfo.js" as Script

Page{
    id: mainPage
    allowedOrientations: Orientation.Portrait | Orientation.Landscape
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
        color: "#08202c"
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
        interval: 2 * 1000
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
