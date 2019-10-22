#!/bin/bash
if [ -z "$NDK" ]; then
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

cd libexif
TARGET=x86_64 API=25 make $@
TARGET=armeabi-v7a API=25 make $@
cd ..
cd libexpat
TARGET=x86_64 API=25 make $@
TARGET=armeabi-v7a API=25 make $@
cd ..
cd libfontconfig
TARGET=x86_64 API=25 make $@
TARGET=armeabi-v7a API=25 make $@
cd ..
cd libfreetype
TARGET=x86_64 API=25 make $@
TARGET=armeabi-v7a API=25 make $@
cd ..
cd libgif
TARGET=x86_64 API=25 make $@
TARGET=armeabi-v7a API=25 make $@
cd ..
cd libharfbuzz
TARGET=x86_64 API=25 make $@
TARGET=armeabi-v7a API=25 make $@
cd ..
cd libjpeg-turbo
TARGET=x86_64 API=25 make $@
TARGET=armeabi-v7a API=25 make $@
cd ..
cd libpng
TARGET=x86_64 API=25 make $@
TARGET=armeabi-v7a API=25 make $@
cd ..
