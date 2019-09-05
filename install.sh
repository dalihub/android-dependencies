#!/bin/bash

if [[ "$DESKTOP_PREFIX" == "" ]] ; then
    echo "Error: DALi DESKTOP_PREFIX environmental variable hasn't been set!"
    exit 0
fi

mkdir -p $DESKTOP_PREFIX/android/lib

files=$(find . -name '*.a' | grep 'armeabi')
cp $files $DESKTOP_PREFIX/android/lib