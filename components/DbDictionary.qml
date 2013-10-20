/**
 * A key-value storage based on LocalStorage
 * Synchronous. Stores strings only.
 * Creates a stand-alone database with a single key-value table
 *
 * Could have been just a small JavaScript library, but I like passing initial state via properties
 */

import QtQuick 2.0
import QtQuick.LocalStorage 2.0 as Ls

// @TODO: exception handling e.g. when creating db

QtObject {
    // Could be "MyAppSettings"
    property string dbName: "sampleDbName"

    // Most of the time you are not interested in even knowing it
    property string dbDescription: dbName

    property string dbVersion: "1.0"

    // Estimated size of DB in bytes. Just a hint for the engine and is ignored as of Qt 5.0 I think
    property int estimatedSize: 1000

    function cleanDb() {
        var db = Ls.LocalStorage.openDatabaseSync(dbName, dbVersion, dbDescription, estimatedSize);
        db.transaction(
                    function(tx) {
                        tx.executeSql("DROP TABLE IF EXISTS dictionary");
                    }
                    );
    }

    function getPreparedDatabase() {
        var db = Ls.LocalStorage.openDatabaseSync(dbName, dbVersion, dbDescription, estimatedSize);
        db.transaction(
            function(tx) {
                tx.executeSql('CREATE TABLE IF NOT EXISTS dictionary(name TEXT, value TEXT, PRIMARY KEY(name))');
            }
                    );
        return db;
    }

    /**
     * @param value Has to be a string. Might work with the other types (e.g. int), but tested with strings only
     * @return true on success, false otherwise
     */
    function saveValue(name, value) {
        var res = false;
        var db = getPreparedDatabase();
        db.transaction(
            function(tx) {
                var rs = tx.executeSql('INSERT OR REPLACE INTO dictionary VALUES (?,?);', [name, value]);
                console.log(rs.rowsAffected)
                if (rs.rowsAffected > 0) {
//                    console.debug("saved " + value +" for " + name + " fine")
                    res = true;
                } else {
                    //@TODO handle error on saving
                    console.error("ERROR: DbDictionary: Failed to save name,value: " +name + ", " +value);
                }
            }
            );
        return res;
    }

    /**
     * @param defaultValue Optional, you get it if wanted property is not found in DB
     * @return Value saved at a given name or defaultValue if not found or undefined if not found and
     *               defaultValue is not specified
     */
    function loadValue(name, defaultValue) {
        if(typeof defaultValue === "undefined") {
            defaultValue = undefined
        }

        var db = getPreparedDatabase();
        var res = defaultValue;
        db.transaction(
            function(tx) {
                var rs = tx.executeSql('SELECT * FROM dictionary WHERE name = ?;', [name]);
                if (rs.rows.length > 0) {
                    res = rs.rows.item(0).value;
                } else {
//                    console.debug("DbDictionary: No value for name " + name)
                }
            }
        );
        console.log("DbDictionary: loadValue: returning " + res + " for " +name)
        return res;
    }
}
