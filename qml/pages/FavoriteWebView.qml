import QtQuick 2.0
import Sailfish.Silica 1.0
import QtWebKit 3.0

Page{
    id:favorite
    property string vol
    property string day


    Component.onCompleted: {
        //webView.url = "http://wufazhuce.com/one/"+vol.toLowerCase();
        webView.url = "http://wufazhuce.com/one/vol.1029#"
    }

    BusyIndicator {
        running: !PageStatus.Active
        size: BusyIndicatorSize.Large
        anchors.centerIn: parent
    }

    SilicaWebView{
        id: webView
        header: PageHeader{
            id:header
            title:vol+"---"+day
        }
        anchors.fill: parent

    }
}
