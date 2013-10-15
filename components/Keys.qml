import QtQuick 2.0

/**
  * Utility object that returns you the key set available that is a demo key set for a public repo or
  * the keys used in production by the app store app
  *
  * Basically checks if a file with the production keys is present and if it does, overrides the default values
  */
QtObject {

    // An instance of KeyBase or its descendant
    // The property is filled ASAP, yet is null right after creation. Check if it's filled already before usage
    property variant keySet: null

    // **internal from here on**
    property variant _loader: Loader {
        id: keysLoader
        source: "AppStoreKeys/AppStoreKeySet.qml"
        onStatusChanged: {
            if(status === Loader.Ready) {
//                console.log("Keys: App store keys loaded fine")
                keySet = item
            } else if(status === Loader.Error) {
                console.log("Keys: Failed to find app store keys, falling back to the default ones")
                keySet = _fallbackKeySet
            }
        }
    }

    // instantiating these dynamically would optimize for performance at a cost of simplicity
    property variant _fallbackKeySet: BaseKeySet {
        id: fallbackKeys
    }

}


