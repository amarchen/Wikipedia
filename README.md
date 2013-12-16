Wikipedia
=========

Wikipedia for Sailfish OS

So far it demonstrates a use of Sailfish Silica library and how you wrap the app, add icon, etc.

Installation, getting started
------------

1. Do a git clone of the sources.
2. Fetch submodules used by running ./init.sh or manually run commands from it if you are on a system without bash shell
It will [hopefully] fail to fetch subcomponent AppStoreKeys that points to the Artem's private repository. That's okay. App should be fully functional without it (will fallback to the default demo keys), if you do have access to that component, app will use keys actually used for the app store.

However, make sure that the directory src/qml/components/AppStoreKeys exists even if empty.

In your own app you probably will do the other way around, have your settings as a part of the main project and use external libraries as submodules. The approach used here is just the simplest way for me (Artem) to show you full app code, yet keep exactly production settings separate.

Build from command line
-----------------------

The following assumes that you have installed the SailfishOS SDK into your home directory under the name SailfishOS, and that you want to build an RPM package that you can install on the Jolla phone.

1. Connect to the virtual machine of the Sailfish SDK build engine:

 ssh -p 2222 -i ~/SailfishOS/vmshare/ssh/private_keys/engine/mersdk mersdk@localhost

2. Change to the same directory where you have your git clone:

 cd git/Wikipedia

3. Prepare the build:

 mb2 -t SailfishOS-armv7hl qmake

4. Execute the build (producing packages in the RPMS directory):

 mb2 -t SailfishOS-armv7hl rpm

Build from SailfishOS IDE
-------------------------

1. File -> Open File or Project... -> Wikipedia/wikipedia.pro

2. Uncheck Desktop, tick MerSDK-SailfishOS-i486-x86 (and/or arm) options

3. Start Sdk and Emulator (bottom-left toolbar icons)

4. Configure build configuration (toolbar icon "wikipedia Debug"): "i486-x86" & "Deploy as RPM package"

5. Run (toolbar play button)

6. Now the application should build, install and launch in the emulator.

7. To use a phone instead of the emulator, switch from "i486-x86" to "arm".

Testing
-------

Tests should be run as
`/usr/share/tst-harbour-wikipedia/runTestsOnDevice.sh` from emulator command line (or specify it as "Use this command instead" inside Creator)

Support and license
-------------------

Best way to get support is to ask at #sailfishos channel at Freenode IRC. If you really-really need to clarify something,
shoot an email to artem.marchenko@gmail.com

License is Attribution-NonCommercial-ShareAlike 3.0 Unported ( http://creativecommons.org/licenses/by-nc-sa/3.0/ )
so as long as you share alike and provide a link to https://github.com/amarchen/Wikipedia (e.g. in your app About dialog)
you are free to reuse the code in any non-commercial project
