import QtQuick 2.1
import Sailfish.Silica 1.0

Page{
    id:tipPage
    property string day
    SilicaListView {
        id: view
        anchors.fill: parent
        ViewPlaceholder {
            enabled: true
            text: qsTr("Something error")
            hintText: qsTr("Click to reload")
            MouseArea{
                anchors.fill: parent
                onClicked:py.getDatas(day);
            }
        }
    }
}
