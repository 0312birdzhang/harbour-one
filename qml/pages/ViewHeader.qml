//import QtQuick 1.1
//import com.nokia.symbian 1.1
import QtQuick 2.0
import Sailfish.Silica 1.0
Item {
    id: root;

    signal clicked

    implicitWidth: screen.width;
    implicitHeight: privateStyle.tabBarHeightPortrait

    Image {
        anchors.fill: parent;
        sourceSize: Qt.size(width, height);
        smooth: true;
        source: "pics/one_home_page_title.png";
        opacity: mouseArea.pressed ? 0.7 : 1
    }

    Image {
        anchors.centerIn: parent;
        source: "pics/one_title.png"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent;
        onClicked: root.clicked()
    }
}
