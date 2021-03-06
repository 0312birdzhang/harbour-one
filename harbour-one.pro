# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-one

CONFIG += sailfishapp

SOURCES += src/harbour-one.cpp

OTHER_FILES += qml/harbour-one.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-one.spec \
    rpm/harbour-one.yaml \
    translations/*.ts \
    harbour-one.desktop \
    qml/pages/main.js \
    qml/pages/storage.js \
    qml/pages/AboutPage.qml \
    qml/pages/ContentPage.qml \
    qml/pages/HomePage.qml \
    qml/pages/ImagePage.qml \
    qml/pages/QuestionPage.qml \
    qml/pages/SignalCenter.qml \
    qml/pages/Notification.qml \
    qml/pages/ErrorTipPage.qml \
    qml/pages/SignalCenter.qml \
    qml/cover/cover.png \
    qml/pages/getBeforeDate.js \
    rpm/harbour-one.changes \
    qml/pages/py/main.py \
    qml/pages/py/sgmllib.py \
    qml/pages/MainPage.qml \
    qml/pages/LabelText.qml \
    qml/pages/py/basedir.py \
    qml/pages/py/feedparser/ \
    qml/pages/py/__init__.py \
    qml/pages/FavoritePage.qml

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-one-de.ts \
                translations/harbour-one-zh_CN.ts


