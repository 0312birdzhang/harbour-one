//import QtQuick 1.1
//import com.nokia.symbian 1.1
import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: root;

    property string icon;

    property Item tab;
    property bool checked: tabGroup.currentTab == tab;

    implicitWidth: screen.width / 5;
    implicitHeight: privateStyle.toolBarHeightPortrait

    Image {
        property string iconState: root.checked||mouseArea.pressed?"press_down":"button";
        anchors.fill: parent;
        sourceSize: Qt.size(width, height);
        smooth: true;
        source: "pics/one_"+root.icon+"_page_"+iconState+".9.png"
    }

    MouseArea {
        id: mouseArea;
        anchors.fill: parent;
        onClicked: {
            tabGroup.currentTab = tab;
        }
    }
}
