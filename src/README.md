Wikipedia
=========

Wikipedia for Sailfish OS

So far it demonstrates a use of Sailfish Silica library and how you wrap the app, add icon, etc.

Installation
------------

Just do a git clone or download the sources.
There is one subcomponent AppStoreKeys that points to the Artem's private repository. App should be fully functional without it (will fallback to the default demo keys), if you do have access to that component, app will use keys actually used for the app store.


In your own app you probably will do the other way around, have your settings as a part of the main project and use external libraries as submodules. The approach used here is just the simplest way for me (Artem) to show you full app code, yet keep exactly production settings separate.


Support and license
-------------------

Best way to get support is to ask at #sailfishos channel at Freenode IRC. If you really-really need to clarify something,
shoot an email to artem.marchenko@gmail.com

License is Attribution-NonCommercial-ShareAlike 3.0 Unported ( http://creativecommons.org/licenses/by-nc-sa/3.0/ )
so as long as you share alike and provide a link to https://github.com/amarchen/Wikipedia (e.g. in your app About dialog)
you are free to reuse the code in any non-commercial project
