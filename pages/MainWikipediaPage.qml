import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica.theme 1.0

import QtWebKit 3.0


Page {
    id: mainWikipediaPage

    SearchField {
        id: searchField
        property string acceptedInput: ""

        placeholderText: "Search.."
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        Component.onCompleted: {
            acceptedInput = ""
            _editor.accepted.connect(searchEntered)
        }

        // is called when user presses the Return key
        function searchEntered() {
            searchField.acceptedInput = text
        }

    }

    SilicaFlickable {
        anchors.top: searchField.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        contentHeight: parent.height - searchField.height
        Rectangle {
            id: backgroundFiller
            anchors.fill: parent
            color: "white"

            WebView {
                id: webView
                width: parent.width
                height: mainWikipediaPage.height
                url: searchField.acceptedInput === "" ? "http://m.wikipedia.org" : "http://m.wikipedia.org/w/index.php?search=" +
                                                       encodeURIComponent(searchField.acceptedInput)
                onUrlChanged: {
                    console.log("5webView url changed to " + url);
                }

            }

            ProgressCircle {
                id: loadingProgressIndicator
                anchors.centerIn: parent
                visible: webView.loading
                value: webView.loadProgress / 100
            }

        }

        PullDownMenu {
            MenuItem {
                text: "About"
                onClicked: {
                    pageStack.push("AboutPage.qml")
                }
            }
        }

    }

    Component.onCompleted: {
        console.log("mainWikipediaPage component completed")
    }
}


