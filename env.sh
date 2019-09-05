# version:
#   https://dl.google.com/android/repository/android-ndk-r19b-linux-x86_64.zip
#   https://dl.google.com/android/repository/cmake-3.10.2-linux-x86_64.zip
#   https://dl.google.com/android/repository/lldb-3.1.4508709-linux-x86_64.zip
# instructions from https://developer.android.com/ndk/guides/other_build_systems
export NDK=/home/SERILOCAL/adam.b/opt/opt/android-sdk/ndk-bundle
export ANDROID_NDK=$NDK
export ARCH=aarch64
export ANDROID_SDK=/home/SERILOCAL/adam.b/opt/opt/android-sdk
export HOST_TAG=linux-x86_64
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$HOST_TAG
export AR=$TOOLCHAIN/bin/${ARCH}-linux-android-ar
export AS=$TOOLCHAIN/bin/${ARCH}-linux-android-as
export CC=$TOOLCHAIN/bin/${ARCH}-linux-android28-clang
export CXX=$TOOLCHAIN/bin/${ARCH}-linux-android28-clang++
export LD=$TOOLCHAIN/bin/${ARCH}-linux-android-ld
export RANLIB=$TOOLCHAIN/bin/${ARCH}-linux-android-ranlib
export STRIP=$TOOLCHAIN/bin/${ARCH}-linux-android-strip
export SYSROOT=$TOOLCHAIN/sysroot
export PATH=$TOOLCHAIN/bin:$PATH
export CFLAGS="--sysroot=$SYSROOT -m32"
export CXXFLAGS="–sysroot=$SYSROOT -m32"
export HOST=${ARCH}-linux-androideabi
