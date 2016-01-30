import QtQuick 2.0
import Sailfish.Silica 1.0

QtObject{
         id:signalcenter;
         signal loadStarted;
         signal loadFinished;
         signal loadFailed(string errorstring);
         function showMessage(msg)
                 {
                  if (msg||false)
                    {
                      addNotification(msg);
                    }
                 }
        }
