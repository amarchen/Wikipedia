# The name of your app
TARGET = Wikipedia

#CONFIG += sailfishapp
LIBS += -lsailfishapp

# C++ sources
SOURCES += main.cpp

# C++ headers
HEADERS +=

# QML files and folders
qml.files = *.qml pages cover components main.qml Wikipedia.png

# The .desktop file
desktop.files = Wikipedia.desktop
appicon.files = Wikipedia.png

# Please do not modify the following line.
#include(sailfishapplication/sailfishapplication.pri)

OTHER_FILES = \
    ../rpm/Wikipedia.spec \
    pages/MainWikipediaPage.qml

###### used to be in sailfishapplication.pri
QT += quick qml

INCLUDEPATH += $$PWD

TARGETPATH = /usr/bin
target.path = $$TARGETPATH

DEPLOYMENT_PATH = /usr/share/$$TARGET
qml.path = $$DEPLOYMENT_PATH
desktop.path = /usr/share/applications
appicon.path = /usr/share/icons/hicolor/90x90/apps

contains(CONFIG, desktop) {
    DEFINES *= DESKTOP
}

INSTALLS += target qml desktop appicon

DEFINES += DEPLOYMENT_PATH=\"\\\"\"$${DEPLOYMENT_PATH}/\"\\\"\"

CONFIG += link_pkgconfig
packagesExist(qdeclarative5-boostable) {
    message("Building with qdeclarative-boostable support")
    DEFINES += HAS_BOOSTER
    PKGCONFIG += qdeclarative5-boostable
} else {
    warning("qdeclarative-boostable not available; startup times will be slower")
}

