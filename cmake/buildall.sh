#!/bin/bash
if [ -z "$ANDROID_SDK" ]; then
    . ./env.sh
fi

if [ -z "$ANDROID_NDK" ]; then
    . ./env.sh
fi

if [ ! -d "$ANDROID_SDK" ]; then
  echo "Please install Android SDK into "$ANDROID_SDK
  exit 1
fi

if [ ! -d "$ANDROID_NDK" ]; then
  echo "Please install Android NDK into "$ANDROID_NDK
  exit 1
fi

export CMAKE_INSTALL_PREFIX=${PREFIX}
export CMAKE_INSTALL_LIBDIR=${CMAKE_INSTALL_PREFIX}/lib/${ANDROID_ABI}
export CMAKE_INSTALL_INCLUDEDIR=${CMAKE_INSTALL_PREFIX}/include
export PKG_CONFIG_LIBDIR=${ANDROID_NDK}/prebuilt/linux-x86_64/lib/pkgconfig
export PKG_CONFIG_PATH=${CMAKE_INSTALL_LIBDIR}/pkgconfig
export CMAKE_C_COMPILER=${ANDROID_NDK}/toolchains/llvm/prebuilt/linux-x86_64/bin/clang
export CMAKE_CXX_COMPILER=${ANDROID_NDK}/toolchains/llvm/prebuilt/linux-x86_64/bin/clang++
export CMAKE_TOOLCHAIN_FILE=${ANDROID_NDK}/build/cmake/android.toolchain.cmake
export CMAKE=${ANDROID_SDK}/cmake/3.10.2.4988404/bin/cmake
export CMAKE_BUILD_TYPE=Release

if [ ! -z "$DEBUG" ]; then
export CMAKE_BUILD_TYPE=Debug
fi

export TOP_DIR=$(pwd) 

buildLib()
{
if [ -d ${TOP_DIR}/$1/cmake/${ANDROID_ABI} ]; then

cd ${TOP_DIR}/$1/cmake/${ANDROID_ABI}

else

mkdir -p ${TOP_DIR}/$1/cmake/${ANDROID_ABI}
cd ${TOP_DIR}/$1/cmake/${ANDROID_ABI}

echo $(pwd)

${CMAKE} ${TOP_DIR}/$1 -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER} -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER} -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} -DANDROID_PLATFORM=${ANDROID_PLATFORM} -DANDROID_ABI=${DANDROID_ABI} -DANDROID_NDK=${ANDROID_NDK} -DANDROID_STL=c++_shared -DCMAKE_C_FLAGS=${CMAKE_C_FLAGS} -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS} -DCMAKE_INSTALL_INCLUDEDIR=${CMAKE_INSTALL_INCLUDEDIR} -DCMAKE_INSTALL_LIBDIR=${CMAKE_INSTALL_LIBDIR} -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} $2

fi

make $3
make install

cd -
}

buildLib "../zlib"
buildLib "../libgif" "-DGIF_SHARED=ON"
buildLib "../libpng" "-DPNG_SHARED=ON"
buildLib "../libjpeg-turbo" "-DENABLE_SHARED=ON" "jpegturbo"
buildLib "../libexpat/expat" "-DBUILD_shared=ON"
buildLib "../libfreetype" "-DBUILD_SHARED_LIBS=ON -DFT_WITH_ZLIB=ON -DFT_WITH_PNG=OFF -DFT_WITH_HARFBUZZ=OFF -DDISABLE_FORCE_DEBUG_POSTFIX=ON -DENABLE_DEVEL=ON"
buildLib "../libharfbuzz" "-DHB_BUILTIN_UCDN=ON -DHB_HAVE_FREETYPE=ON -DBUILD_SHARED_LIBS=ON"
buildLib "../libfreetype" "-DHB_BUILTIN_UCDN=ON -DHB_HAVE_FREETYPE=ON -DBUILD_SHARED_LIBS=ON"
buildLib "../libfontconfig" "-DFONTCONFIG_SHARED=ON -DREAD_ONLY_DIR=/data/data/com.sec.dali_demo/files/fonts"
buildLib "../libcurl" "-DBUILD_CURL_EXE=OFF -DCMAKE_USE_OPENSSL=OFF -DCMAKE_USE_LIBSSH2=OFF -DCURL_CA_PATH=none -DCMAKE_DEBUG_POSTFIX=''"

