import QtQuick 2.0
import Sailfish.Silica 1.0

Page {

    property string version  // to be displayed in the about dialog

    // Internal - for testing
    property alias _i: internals

    // @TODO: Use version label from app's metadata
    Label {
        anchors.centerIn: parent
        width: parent.width
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        horizontalAlignment: Text.AlignHCenter
        text: "Wikipedia app, version " + version + "<br/>" +
              "by Artem Marchenko<br/><br/>" +
              "See more at <a href='https://github.com/amarchen/Wikipedia'>https://github.com/amarchen/Wikipedia</a><br/><br/>" +
              "Ask at <a href='http://webchat.freenode.net/?channels=sailfishos'>#sailfishos</a> channel on Freenode IRC for support"

        onLinkActivated: {
//            Qt.openUrlExternally(link)
            pageStack.push("BrowserPage.qml", {"url": link})
        }
    }

    QtObject {
        id: internals
        property string pageName: "AboutPage"
    }
}
