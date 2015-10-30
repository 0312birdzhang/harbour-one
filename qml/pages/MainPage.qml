/*
    GPL V2
*/

import QtQuick 2.1
import Sailfish.Silica 1.0


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
            CosasPage{}
        }
    }

}
