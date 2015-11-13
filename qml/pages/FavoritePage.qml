import QtQuick 2.0
import Sailfish.Silica 1.0
import "./storage.js" as Storage
import "./getBeforeDate.js" as JS
Page{
    id:favoriteList

    Component.onCompleted: {
        Storage.loadFavorite(listmodel);
    }

    ListModel{
        id:listmodel
    }


    SilicaListView{
        id:listview
        header: PageHeader{
            title:qsTr("Favorites")
        }
        anchors.fill: parent
        clip: true
        spacing:Theme.paddingMedium
        model:listmodel
        delegate: ListItem{

            id:downlist
            menu:contextMenuComponent
            function remove(date) {
                remorseAction(qsTr("Removing..."), function() {
                   Storage.removeFavorite(date);
                    listmodel.remove(index);
                });
            }
            width: parent.width
            ListView.onRemove: animateRemoval()

            Label{
                text:title+"---"+date
                width: parent.width
                font.pixelSize: Theme.fontSizeMedium
                font.bold: true
                //truncationMode: TruncationMode.Fade
                horizontalAlignment: Text.AlignRight
                truncationMode: TruncationMode.Elide
                color:Theme.highlightColor
                anchors {
                    top:parent.top
                    left: parent.left
                    right:parent.right
                    margins: Theme.paddingMedium
                }
            }
            Component {
                id: contextMenuComponent
                ContextMenu {
                    MenuItem {
                        text: qsTr("Delete")
                        onClicked: {
                            remove(date)
                        }
                    }
                }
            }
            onClicked: {
                //var day = date.toString();
                //var diffday = JS.getDiffDay(day);
                var volnum =title.split(".")[1]
                busyIndicator.running = true
                py.getDatas(volnum)
            }
        }
          VerticalScrollDecorator {}
    }
}
