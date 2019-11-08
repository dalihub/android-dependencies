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

if [ "$1" = "clean" ]; then
echo "Cleaning dali dependencies..."
rm -rf ../libcurl/cmake
rm -rf ../libgif/cmake
rm -rf ../libpixman/cmake
rm -rf ../libharfbuzz/cmake
rm -rf ../libexif/cmake
rm -rf ../zlib/cmake
rm -rf ../libcairo/cmake
rm -rf ../libfribidi/cmake
rm -rf ../libexpat/expat/cmake
rm -rf ../libfreetype/cmake
rm -rf ../libfontconfig/cmake
rm -rf ../libjpeg-turbo/cmake
rm -rf ../libpng/cmake
exit 0
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

if [ ! -z "$SHARED" ]; then
STATIC="OFF"
SHARED="ON"
else
STATIC="ON"
SHARED="OFF"
fi

buildLib "../zlib"
buildLib "../libgif" "-DGIF_SHARED=${SHARED} -DGIF_STATIC=${STATIC}"
buildLib "../libpng" "-DPNG_SHARED=${SHARED} -DPNG_STATIC=${STATIC} -DPNG_TESTS=OFF -DCMAKE_DEBUG_POSTFIX='' -DPNG_LIB_NAME='png'"
buildLib "../libexif" "-DEXIF_SHARED=${SHARED} -DEXIF_STATIC=${STATIC}"
buildLib "../libjpeg-turbo" "-DENABLE_SHARED=${SHARED} -DENABLE_STATIC=${STATIC}" "turbojpeg"
buildLib "../libexpat/expat" "-DBUILD_shared=${SHARED}"
buildLib "../libfreetype" "-DBUILD_SHARED_LIBS=${SHARED} -DFT_WITH_ZLIB=ON -DFT_WITH_PNG=ON -DPNG_LIBRARY=${CMAKE_INSTALL_LIBDIR}/libpng.a -DPNG_PNG_INCLUDE_DIR=${CMAKE_INSTALL_INCLUDEDIR}/libpng16 -DFT_WITH_HARFBUZZ=OFF -DDISABLE_FORCE_DEBUG_POSTFIX=ON -DENABLE_DEVEL=ON"
buildLib "../libharfbuzz" "-DHB_BUILTIN_UCDN=ON -DHB_HAVE_FREETYPE=ON -DBUILD_SHARED_LIBS=${SHARED} -DHB_BUILD_TESTS=OFF"
buildLib "../libfontconfig" "-DFONTCONFIG_SHARED=${SHARED} -DFONTCONFIG_STATIC=${STATIC} -DREAD_ONLY_DIR=fonts -DFONTCONFIG_INSTALL_PATH='${PREFIX}/files/fonts'"
buildLib "../libfribidi" "-DFRIBIDI_SHARED=${SHARED} -DFRIBIDI_STATIC=${STATIC}"
buildLib "../libcurl" "-DBUILD_SHARED_LIBS=${SHARED} -DBUILD_CURL_EXE=OFF -DCMAKE_USE_OPENSSL=OFF -DCMAKE_USE_LIBSSH2=OFF -DCURL_CA_PATH=none -DCMAKE_DEBUG_POSTFIX=''"
buildLib "../libpixman" "-DPIXMAN_SHARED=${SHARED} -DPIXMAN_STATIC=${STATIC}"
buildLib "../libcairo" "-DCAIRO_SHARED=${SHARED} -DCAIRO_STATIC=${STATIC}"

