#!/bin/bash
# Script based on https://blog.joshumax.me/general/2018/01/19/building-wine-3-0-on-android.html
# and https://github.com/AndreRH/hangover/blob/8b38d20d5f5f1a5a546ee8e62a6623d2a9bec1bf/build.android.sh

SRCDIR=/home/$USER/wine-hangover-8.17

cd $SRCDIR

# Path to NDK bin and llvm-mingw
export PATH=/home/$USER/android-ndk-r23c/toolchains/llvm/prebuilt/linux-x86_64/bin:/home/$USER/llvm-mingw/bin:$PATH

# Path to NDK sysroot
export NDK_SYSROOT=/home/$USER/android-ndk-r23c/toolchains/llvm/prebuilt/linux-x86_64/sysroot

# Path to Android SDK
export ANDROID_HOME=/home/$USER/Android/Sdk

export CFLAGS="-O2"

# Termux headers and libs (Freetype and Pulseaudio)
export FREETYPE_CFLAGS="-I /home/$USER/termux/include/freetype2"
export FREETYPE_LIBS="-L /home/$USER/termux/lib"
export PULSE_CFLAGS="-I /home/$USER/termux/include"
export PULSE_LIBS="-L /home/$USER/termux/lib"

# Configure with X11 headers and libs from Termux
./configure --host=aarch64-linux-android --with-wine-tools=/home/$USER/wine-native --disable-tests	\
		CXX=aarch64-linux-android28-clang++ CC=aarch64-linux-android28-clang			\
		--with-mingw --enable-archs=i386,aarch64 --with-opengl --with-pulse --with-x		\
		--with-xcomposite --with-xcursor --with-xfixes --with-xrandr --with-xrender		\
		--x-includes="/home/$USER/termux/include" --x-libraries="/home/$USER/termux/lib" 

make -j`nproc` && make DESTDIR=~/wine_build install
