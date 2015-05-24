/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "pages/main.js" as Script
import io.thp.pyotherside 1.4

ApplicationWindow
{

    id: app;
    property int allindex: 0
    property int num:0
    allowedOrientations: Orientation.Portrait | Orientation.Landscape
//    property int homeindex: 0
//    property int contentindex: 0
//    property int questionindex: 0
    property string homepageImg:"image://theme/icon-m-refresh"
    initialPage:Component {
        MainPage{id:mainPage}

    }
    SignalCenter { id: signalCenter; }

    Connections {
        target: signalCenter;
        onLoadStarted: {
            processingTimer.restart();
        }
        onLoadFinished: {
            processingTimer.stop();
        }
        onLoadFailed: {
            processingTimer.stop();
            signalCenter.showMessage(errorString);
        }
        onShowMessage: {
            if (message||false){
//                infoBanner.text = message;
//                infoBanner.open();
                  addNotification(message,3);
            }
        }
    }
    Item{
        id:notiItem
        width: parent.width
        height:Screen.height/5
        z: 20
        Column {
            id: notificationBar
            anchors {
                top:parent.top
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                margins:Theme.paddingMedium
            }
            spacing: Theme.paddingMedium
            move: Transition { NumberAnimation { properties: "y" } }
        }
    }

    function addNotification(inText, inTime) {
        var text = inText == undefined ? "" : inText
        var time = inTime == undefined ? 4 : inTime
        var noti = Qt.createComponent("pages/Notification.qml")
        if (noti.status == Component.Ready) {
            var notiItem = noti.createObject(notificationBar, { "text": text, "time": time })
        }
    }

    Python{
        id:py
        Component.onCompleted: { // this action is triggered when the loading of this component is finished
            addImportPath(Qt.resolvedUrl('./pages/py')); // adds import path to the directory of the Python script
            py.importModule('main', function () { // imports the Python module
            });
        }

        //注册保存方法
        function saveImg(basename,volname){
            console.log("img:"+volname+",basename:"+basename);
            call('main.saveImg',[basename,volname],function(result){
                return result
            })
        }
        //注册缓存方法
        function cacheImg(url,md5name){
            call('main.cacheImg',[url,md5name],function(result){
                homepageImg = result;
                console.log("local path:"+result)
            })
            //return "image://theme/icon-m-refresh"
        }
        function clearCache(){
            call('main.clearImg',[],function(result){
                   return result
            })
        }

        onError: signalCenter.showMessage(traceback)
        onReceived: {
            console.log('Event: ' + data);
            var sendMsg="";
            switch(data.toString()){
            case "1":
                sendMsg=qsTr("Successed saved to ~/Pictures/save/One/")
                break;
            case "-1":
                sendMsg=qsTr("Error")
                break;
            case "2":
                sendMsg=qsTr("Cleared")
                break;
            default:
                sendMsg=qsTr("Unknown")
            }

            signalCenter.showMessage(sendMsg)
        }
    }

    Timer {
        id: processingTimer;
        interval: 30000;
        onTriggered: signalCenter.loadFailed(qsTr("Network Time Out> <"));
    }

    Component.onCompleted: {
        Script.signalCenter = signalCenter;
    }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
}


