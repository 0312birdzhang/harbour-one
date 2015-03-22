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
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/harbour-one.changes.in \
    rpm/harbour-one.spec \
    rpm/harbour-one.yaml \
    translations/*.ts \
    harbour-one.desktop \
    qml/pages/main.js \
    qml/pages/storage.js \
    qml/pages/one_zh_CN.qm \
    qml/pages/AboutPage.qml \
    qml/pages/ContentPage.qml \
    qml/pages/HomePage.qml \
    qml/pages/ImagePage.qml \
    qml/pages/MainPage.qml \
    qml/pages/MorePage.qml \
    qml/pages/OneTabButton.qml \
    qml/pages/QuestionPage.qml \
    qml/pages/SignalCenter.qml \
    qml/pages/SingleContent.qml \
    qml/pages/StowPage.qml \
    qml/pages/ViewHeader.qml \
    qml/pages/default_theme.css

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-one-de.ts

