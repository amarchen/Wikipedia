# The name of your app
TARGET = harbour-wikipedia

CONFIG += sailfishapp

# C++ sources
SOURCES += main.cpp

# somehow modifying .prf wasn't good enough
icon86.files = $${TARGET}.png
icon86.path = /usr/share/icons/hicolor/86x86/apps
INSTALLS += icon86

# C++ headers
HEADERS +=

OTHER_FILES = \
    ../rpm/harbour-wikipedia.yaml \
    ../rpm/harbour-wikipedia.spec \
    qml/main.qml \
    qml/pages/MainWikipediaPage.qml \
    qml/pages/AboutPage.qml \
    qml/pages/BrowserPage.qml \
    qml/pages/TweetDialog.qml \
    qml/cover/CoverPage.qml \
    qml/components/BaseKeySet.qml

INCLUDEPATH += $$PWD
