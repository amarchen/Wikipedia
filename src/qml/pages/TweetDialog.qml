import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: wholeTweetDialog

    // URL and text to show when initializing the view (user can change it later, we won't reflect it to these properties)
    property url initialUrl: ""
    property string initialText: ""
    // well, probably posted
    signal postedTweet(string initialUrl, string initialText)


    // Internal
    property bool _tweetProbablyPosted: false

    // @TODO: Report to public tracker (whenever it's created) that default acceptance text is still shown for a while
    DialogHeader {
        id: dialogHeader
        // It's a little ugly, but maybe better than showing "Done" while user is still about to post tweet
        // Whole dialog will anyway be replaced with the proper nemo social plugin use at some point
        acceptText: _tweetProbablyPosted ? "Done" : "Cancel"
    }

    SilicaWebView {
        id: tweetWebView
        anchors.left: parent.left
        anchors.top: dialogHeader.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        url: prepareInitialUrl()

        onLoadingChanged: {
            // A bit of heuristics to change the accept label when we think user posted a tweet
            // Will be made irrelevant when we switch to the proper nemo social plugin
            if((loadRequest.status === WebView.LoadSucceededStatus) &&
                    (url.toString().indexOf("/tweet/complete") != -1 )) {
                _tweetProbablyPosted = true
            } else {
                _tweetProbablyPosted = false
            }
        }

    }

    function prepareInitialUrl() {
        var res = "https://twitter.com/intent/tweet?text="
        res += encodeURIComponent(initialText)
        res += "&url="
        res += encodeURIComponent(initialUrl)
        return res
    }

    on_TweetProbablyPostedChanged: {
        if(_tweetProbablyPosted) {
            postedTweet(initialUrl, initialText)
        }
    }

}
