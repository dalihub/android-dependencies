if [ ! -d "$ANDROID_SDK" ]; then
# try default path
if [ -d "$HOME/Android/Sdk" ]; then
export ANDROID_SDK=$HOME/Android/Sdk
fi
fi

if [ ! -d "$ANDROID_NDK" ]; then
# try to find in default location inside SDK
if [ -d $ANDROID_SDK ]; then
NDK_DIR=$(find $ANDROID_SDK -maxdepth 2 -name ndk-build | sed 's/\/ndk-build//')
if [ -d "$NDK_DIR" ]; then
export ANDROID_NDK=$NDK_DIR
fi
fi
fi



