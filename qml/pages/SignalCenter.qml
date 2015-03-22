import QtQuick 1.1

QtObject {
    signal loadStarted;
    signal loadFinished;
    signal loadFailed(string errorString);

    signal getContentDataFinished(variant data)

    signal showMessage(string message);

    signal addToFavorite(string date, string title)
    signal removeFromFavorite(string date)

    signal headerClicked
}
