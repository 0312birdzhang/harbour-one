import QtQuick 1.1
import com.nokia.symbian 1.1
import "storage.js" as Database

Page {
    id: stowPage;

    orientationLock: PageOrientation.LockPortrait

    property bool firstStart: true
    onVisibleChanged: {
        if (visible && firstStart){
            firstStart = false;
            Database.loadFavorite(stowModel)
        }
    }

    Connections {
        target: signalCenter
        onAddToFavorite: {
            Database.addFavorite(date, title);
            signalCenter.showMessage(qsTr("Success!"))
            if (!firstStart){
                for (var i=0,l=stowModel.count; i<l; i++){
                    if (stowModel.get(i).date == date)
                        return;
                }
                stowModel.append({"date":date, "title":title})
            }
        }
        onRemoveFromFavorite: {
            Database.removeFavorite(date);
            signalCenter.showMessage(qsTr("Success!"))
            for (var i=0, l=stowModel.count; i<l; i++){
                if (stowModel.get(i).date == date){
                    stowModel.remove(i);
                    break;
                }
            }
        }
    }

    ListView {
        id: view
        anchors.fill: parent;
        clip: true;
        model: ListModel { id: stowModel; }
        delegate: ListItem {
            platformInverted: true;
            subItemIndicator: true;
            ListItemText {
                anchors {
                    left: parent.paddingItem.left; right: parent.paddingItem.right;
                    verticalCenter: parent.verticalCenter;
                }
                text: model.title;
                platformInverted: true;
            }
            onClicked: {
                var p = pageStack.push(Qt.resolvedUrl("SingleContent.qml"),{"date": model.date})
                p.getData();
            }
        }
    }

    Component.onCompleted: {
        Database.initialize();
    }
}
