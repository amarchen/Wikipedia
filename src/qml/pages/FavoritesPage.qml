import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {

    signal favouriteChosen(string title, string url)

    FavouritesData {
        id: favouritesData
    }

    SilicaListView {
        anchors.fill: parent
        header: PageHeader { title: "Favourites" }

        model: favouritesData.favourites

        delegate: ListItem {
            id: listItem
            contentHeight: Theme.itemSizeSmall
            ListView.onRemove: animateRemoval(listItem)

            Label {
                id: titleLabel
                text: title
                color: listItem.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: {
                favouriteChosen(title, url)
                pageStack.pop()
            }
        }
    }
}
