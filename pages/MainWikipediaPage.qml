import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica.theme 1.0

import QtWebKit 3.0


Page {
    id: mainWikipediaPage
    
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: parent.height
        WebView {
            width: parent.width
            height: mainWikipediaPage.height
            url: "http://www.wikipedia.org"
        }
    }

    Component.onCompleted: {
        console.log("mainWikipediaPage component completed")
    }
}


