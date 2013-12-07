/**
 * Tests favorurites storage on the DB leve
 */
import QtQuick 2.0
import QtTest 1.0
import QtQuick.LocalStorage 2.0 as Ls

//import "../src/qml/components"
import "../harbour-wikipedia/qml/components"


TestCase {
    id: wholeCase

    readonly property string dbName: "testWikipedia"

    Component {
        id: favouritesDataComponent
        FavouritesData {
            dbName: wholeCase.dbName
        }
    }

    property var fd: null

    function clearDatabase() {
        var db = Ls.LocalStorage.openDatabaseSync(dbName, "1.0", "", 1000);
        db.transaction(
            function(tx) {
                tx.executeSql('DROP TABLE IF EXISTS favourites');
            }
        );
        return db;
    }

    function recordsCount() {
        var db = Ls.LocalStorage.openDatabaseSync(dbName, "1.0", "", 1000);
        var count = -1;
        db.transaction(
            function(tx) {
                var rs = tx.executeSql('SELECT * FROM favourites;');
                count = rs.rows.length
            }
        );
        return count;
    }

    function init() {
        clearDatabase()
        fd = favouritesDataComponent.createObject(null)
    }

    function cleanup() {
        fd.destroy()
        fd = null
        clearDatabase()
    }

    function test_emptyDbResultsInEmptyModel() {
        compare(fd.favourites.count, 0)
    }

    function test_canSaveFavouritesToDisk() {
        fd.favourites.append({title: "ABC", url:"http://abc.com"})
        fd.favourites.append({title: "DEF", url:"http://def.com"})
        fd.save()
        console.log("t: abt to compare")
        compare(recordsCount(), 2)
    }
}
