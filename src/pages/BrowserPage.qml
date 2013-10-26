import QtQuick 2.0
import Sailfish.Silica 1.0

import QtWebKit 3.0

// There is no stand-alone browser in the simulator just yet, so Qt.openUrlExternally doesn't work
// Well, let's open browser inside then
Page {
    property alias url: webView.url
    SilicaFlickable {
        anchors.fill: parent

        WebView {
            id: webView
            anchors.fill: parent
            url: "http://www.google.com"
        }
    }
}
