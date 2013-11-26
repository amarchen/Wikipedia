/**
 * User level test for the main interactions
 * Well, just a dummy one for now
 */

import QtQuick 2.0
import QtTest 1.0
import Sailfish.Silica 1.0


//import "../src/pages"
import "../harbour-wikipedia/qml/pages"


// Putting TestCase into the full app structure to test UI interactions and probably page transitions too
ApplicationWindow {
    id: wholeApp
    initialPage: MainWikipediaPage {
        id: mainPage
    }

    TestCase {
        name: "test on the very UI level"

        // You want see anything yet at this moment, but UI is actually constructed already and e.g. mouseClick will work
        // Painting happens later, you can set up timer to wait for it (painting happens some 50-100ms after ApplicationWindow's
        // applicationActive becomes true), then you might be able to
        // see graphics update when test is clicking through buttons, though you might need to yield control from time to time then
        when: windowShown

        function test_AboutPageShownAfterMenuClick() {
            mainPage._i.aboutMenuItem.clicked(null)
            compare(pageStack.currentPage._i.pageName, "AboutPage")
        }
    }

}



