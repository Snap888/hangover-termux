#!/bin/bash
# Script based on https://blog.joshumax.me/general/2018/01/19/building-wine-3-0-on-android.html

SRCDIR=/home/$USER/wine-hangover-8.17

cp -r $SRCDIR /home/$USER/wine-native

cd wine-native

#Build Wine-tools

./configure --enable-win64

make -j`nproc` 

