#!/bin/bash

############################# x264 CONFIG
X264_SOURCE=$SOURCE/x264
X264_GIT_REPO="git://git.videolan.org/x264.git"
X264_INSTALL_PREFIX="/usr/local"

if [ ! -e "$X264_SOURCE" ]
then
	cd $SOURCE
	git clone $X264_GIT_REPO
else
	cd $X264_SOURCE
	git pull
	cd ..
fi

cd $X264_SOURCE
./configure --prefix=$X264_INSTALL_PREFIX --enable-static --enable-shared
make
sudo make install