
#!/bin/bash
echo Initializing repository - Fetching git submodules used

git submodule init
git submodule update src/qml/components/Mixpanel/
git submodule update || mkdir -p src/qml/components/AppStoreKeys
