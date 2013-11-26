import QtQuick 2.0
import Sailfish.Silica 1.0

import QtWebKit 3.0

import harbour.wikipedia.Mixpanel 0.1
import "../components"

Page {
    id: mainWikipediaPage

    // Wikipedia used. Used subdomain name to be precise
    property string usedUrlCode: "en"

    // Language selection menu is functional only if combobox opens to a separate page
    // At the moment it needs to have at least this many items for it. A hack of course
    property int _MIN_MENU_ITEM_COUNT_FOR_COMBOBOX_TO_OPEN_IN_A_SEPARATE_VIEW: 7

    // Exposes some internal stuff for testing purposes only
    property alias _i: internals

    ListModel {
        id: supportedLangsModel
        ListElement {name: "English"
                     urlCode: "en"}
        ListElement {name: "Finnish"
                     urlCode: "fi"}
        ListElement {name: "French"
                     urlCode: "fr"}
        ListElement {name: "Potrtuguese"
                     urlCode: "pt"}
        ListElement {name: "Russian"
                     urlCode: "ru"}
        ListElement {name: "Spanish"
                     urlCode: "es"}
        ListElement {name: "Ukrainian"
                     urlCode: "uk"}
    }

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
                url: "http://" + usedUrlCode + ".m.wikipedia.org/"
                     + (searchField.acceptedInput === "" ? "" : "w/index.php?search=" +
                                                                encodeURIComponent(searchField.acceptedInput)
                       )
                onUrlChanged: {
                    console.log("webView url changed to " + url);
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
                ComboBox {
                    id: langSelectionBox

                    label: "Choose language"
                    currentIndex: langModelIndexByUrlCode(usedUrlCode)

                    menu: ContextMenu {
                        Repeater {
                            model: supportedLangsModel
                            MenuItem {text: name
                            }
                        }
                        onActivated: {
                            usedUrlCode = supportedLangsModel.get(index).urlCode
                        }

                    }

                    Component.onCompleted: {
                        alertIfComboBoxDoesNotNeedASeparateMenu(menu)
                    }

                }
                onClicked: {
                    langSelectionBox.clicked(null)
                }
            }

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
                id: aboutMenuItem
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

    //  Start of Fix for nov 2013
    DbDictionary {
        id: dictionary
        dbName: "WikipediaSettings"
    }

//    DeviceInfo {
//        id: devinfo
//    }
    QtObject {
        id: devinfo

        // will be updated on demand
        property string _userId: ""

        function imei() {
            if (_userId === "") {
                _userId = provideUserId();
            }
            return _userId;
        }

        // Loads one from DB or generates a new one and saves it do DB
        function provideUserId() {
            var savedId = dictionary.loadValue("userId", null)
            if(savedId === null)
            {
//                console.log("no saved userId, generating")
                // let it be from 0 to a billion
                savedId = Math.floor(Math.random() * 1000000000).toString()
                dictionary.saveValue("userId", savedId)
            }

            return savedId
        }

    }
    //  End of Fix for nov 2013

    onUsedUrlCodeChanged: {
        mixpanel.track("chose lang", {lang: usedUrlCode})
        dictionary.saveValue("wikipediaUrlCodeUsed", usedUrlCode)
    }

    // Just prints a warning if number of langs is not enough for forcing combo box opening in  separate page
    // It won't be functional then
    // @param menu ComboBox'es ContextMenu
    function alertIfComboBoxDoesNotNeedASeparateMenu(menu) {
        var menuChildrenCount = 0
        for (var i=0; i<menu._contentColumn.children.length; i++) {
            var child = menu._contentColumn.children[i]
            if (child && child.hasOwnProperty("__silica_menuitem")) {
                ++menuChildrenCount
            }
        }
        console.assert(menuChildrenCount >= _MIN_MENU_ITEM_COUNT_FOR_COMBOBOX_TO_OPEN_IN_A_SEPARATE_VIEW,
                       "ERROR: lang selection menu has only " + menuChildrenCount +" items, must have at least "
                       + _MIN_MENU_ITEM_COUNT_FOR_COMBOBOX_TO_OPEN_IN_A_SEPARATE_VIEW)
    }

    // @return -1 if given code isn't found
    function langModelIndexByUrlCode(urlCode, langModel) {
        for(var i=0; i < langModel.count; i++) {
            if(langModel.get(i).urlCode === urlCode) {
                return i
            }
        }
        return -1
    }

    QtObject {
        id: internals
        property string pageName: "MainWikipediaPage"
        property alias aboutMenuItem: aboutMenuItem
    }

    Component.onCompleted: {
        usedUrlCode = dictionary.loadValue("wikipediaUrlCodeUsed", "en")
    }

}


