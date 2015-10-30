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
import "pages/storage.js" as Storage
import "pages/getBeforeDate.js" as GetDate
import io.thp.pyotherside 1.3
import org.nemomobile.notifications 1.0

ApplicationWindow{
    id: app;
    property int allindex: 0
    property int num:0
    property var objects
    property string homepageImg:"image://theme/icon-m-refresh"
    

    onObjectsChanged: {
        gotoHomePage();
    }

    allowedOrientations: Orientation.Portrait | Orientation.Landscape
    
    initialPage:Component {
        Page{
            id:firestpage
            Rectangle {
                id: splash
                anchors.fill: parent;
                color: "#483D8B"
                Image {
                    id:wel1
                    anchors.horizontalCenter: parent.horizontalCenter
                    y:parent.height/16*7-implicitHeight/2;
                    source: "pages/pics/welcome_image_1.png"
                }
                Image {
                    id:wel2
                    anchors.horizontalCenter: parent.horizontalCenter
                    y:parent.height/4*3;
                    source: "pages/pics/welcome_image_2.png"
                }
                Image {
                    id:wel3
                    anchors.top: wel2.bottom;
                    anchors.topMargin: Theme.paddingMedium
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "pages/pics/welcome_image_name.png"
                }
                NumberAnimation on opacity {duration: 500}
            }
//            Timer {
//                id: timerDisplay
//                running: true; repeat: false; triggeredOnStart: false
//                interval: 1 * 1000
//                onTriggered: {
//                    splash.visible = false;
//                }
//            }
        }


    }

    Notification{
        id:notification
        appName: "One"
    }

   function addNotification(message) {
       notification.previewBody = "One";
       notification.previewSummary = message;
       notification.close();
       notification.publish();
   }

    function gotoHomePage(){
        while(pageStack.depth>1) {
            pageStack.pop(undefined, PageStackAction.Immediate);
        }
        pageStack.replace(Qt.resolvedUrl("pages/MainPage.qml"));
    }


    Python{
        id:py
        Component.onCompleted: { // this action is triggered when the loading of this component is finished
            addImportPath(Qt.resolvedUrl('./pages/py')); // adds import path to the directory of the Python script
            py.importModule('main', function () { // imports the Python module
                    py.getDatas(GetDate.getDiffDay("2012-10-07"));
              });
            
        }

        function getDatas(volnum){
            console.log("volnum:"+volnum);
            call('main.getTodayContent',[volnum],function(result){
                objects = result;
            })
        }
        //注册保存方法
        function saveImg(basename,volname){
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

        onError: {

            addNotification(traceback)
        }
        onReceived: {
            //console.log('Event: ' + data);
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

            addNotification(sendMsg)
        }
    }

    Timer {
        id: processingTimer;
        interval: 30000;
        onTriggered: signalCenter.loadFailed(qsTr("Network Time Out> <"));
    }

    Component.onCompleted: {
        Storage.initialize();
    }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
}
