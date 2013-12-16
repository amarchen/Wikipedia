# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-wikipedia

CONFIG += sailfishapp
DEPLOYMENT_PATH = /usr/share/$$TARGET

# moving mixpanel to harbour.wikipedia.Mixpanel location to satisfy new harbour requirements
# qml.files/path will deploy a copy to the old location, but it's ok, it's not going to be used
mixpanel.files = qml/components/Mixpanel/src/Mixpanel/*
mixpanel.path = $$DEPLOYMENT_PATH/qml/components/harbour/wikipedia/Mixpanel

INSTALLS += mixpanel

QML_IMPORT_PATH += $$PWD/qml/components/Mixpanel/src

DEFINES += APP_VERSION=\\\"$$VERSION\\\"
DEFINES += APP_BUILDNUM=\\\"$$RELEASE\\\"


SOURCES += main.cpp

OTHER_FILES = \
    ../rpm/harbour-wikipedia.yaml \
    ../rpm/harbour-wikipedia.spec \
    qml/main.qml \
    qml/pages/MainWikipediaPage.qml \
    qml/pages/AboutPage.qml \
    qml/pages/BrowserPage.qml \
    qml/pages/TweetDialog.qml \
    qml/cover/CoverPage.qml \
    qml/components/BaseKeySet.qml \
    qml/components/FavouritesData.qml \
    qml/pages/FavouritesPage.qml

INCLUDEPATH += $$PWD
