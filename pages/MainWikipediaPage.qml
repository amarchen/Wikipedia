import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Silica.theme 1.0

import QtWebKit 3.0
import QtSystemInfo 5.0

import "../components"

Page {
    id: mainWikipediaPage

    SearchField {
        id: searchField
        property string acceptedInput: ""

        placeholderText: "Search.."
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        EnterKey.enabled: text.trim().length > 0
        EnterKey.text: "Go!"

        Component.onCompleted: {
            acceptedInput = ""
            _editor.accepted.connect(searchEntered)
        }

        // is called when user presses the Return key
        function searchEntered() {
            searchField.acceptedInput = text
            mixpanel.track("searched", {text: text} )
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
                text: "Tweet"
                onClicked: {
                    pageStack.push("TweetDialog.qml", {initialText: webView.title + " via @WikiSailfish", initialUrl: webView.url})
                    mixpanel.track("opened Tweet dialog")

                    var tweetDialog = pageStack.currentPage
                    tweetDialog.postedTweet.connect(function(initialUrl, initialText) {
                        mixpanel.track("posted tweet", {initialUrl: initialUrl, initialText: initialText})
                    })
                }
            }
            MenuItem {
                text: "About"
                onClicked: {
                    pageStack.push("AboutPage.qml")
                    mixpanel.track("opened About page")
                }
            }
        }

    }

    Keys {
        onKeySetChanged: {
            console.log("keys changed to " + JSON.stringify(keySet))
            if(keySet) {
                mixpanel.mixpanelToken = keySet.mixpanelToken
                mixpanel.track("started")
            }
        }
    }

    Mixpanel {
        id: mixpanel
        userId: devinfo.imei(0) == "" ? "emulatorImei" : devinfo.imei(0)
    }

    DeviceInfo {
        id: devinfo
    }

}


