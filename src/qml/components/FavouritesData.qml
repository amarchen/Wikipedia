/**
 * In-memory representation of favorites. Knows how to save them to disk and load back
 * @TODO Refactor out duplication with DbDictionary
 * @TODO Handle SQL exceptions
 */
import QtQuick 2.0
import QtQuick.LocalStorage 2.0 as Ls

QtObject {
    /**
     * Elements are to be {title: "Wikipedia", url: "http://www.wikipedia.org"}
     */
    property ListModel favourites: ListModel {}

    property string dbName: "WikipediaFavorites"

    property string dbVersion: "1.0";

    /**
     * Saves current favourites model to disk
     */
    function save() {
        var db = _getPreparedDatabase()
        db.transaction(
            function(tx) {
                tx.executeSql('DELETE FROM favourites');
            }
        );
        for(var i=0; i < favourites.count; i++) {
            db.transaction(
                function(tx) {
                    tx.executeSql('INSERT INTO favourites VALUES(?, ?)', [favourites.get(i).title, favourites.get(i).url])
                }

            );
        }
    }

    /**
     * Loads favourites from disk to in-memory model
     */
    function load() {
        favourites.clear()
        var db = _getPreparedDatabase()
        db.transaction(
            function(tx) {
                var rs = tx.executeSql('SELECT * FROM favourites ORDER BY title;');
                for(var i=0; i < rs.rows.length; i++) {
                    favourites.append({title: rs.rows.item(i).title, url: rs.rows.item(i).url})
                }
            }
        );
    }

    function _getPreparedDatabase() {
        var db = Ls.LocalStorage.openDatabaseSync(dbName, dbVersion, "", 1000);
        db.transaction(
            function(tx) {
                tx.executeSql('CREATE TABLE IF NOT EXISTS favourites(title TEXT, url TEXT)');
            }
                    );
        return db;
    }

    Component.onCompleted: {
        load()
    }
}
