import QtQuick 2.0
import Sailfish.Silica 1.0

// There is no stand-alone browser in the simulator just yet, so Qt.openUrlExternally doesn't work
// Well, let's open browser inside then
Page {
    property alias url: webView.url

    SilicaWebView {
        header: PageHeader {
            title: "Web"
        }

        id: webView
        anchors.fill: parent
    }
    ProgressCircle {
        id: loadingProgressIndicator
        anchors.centerIn: parent
        visible: webView.loading
        value: webView.loadProgress / 100
    }

}
