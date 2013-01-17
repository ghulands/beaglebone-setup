#!/bin/bash

############################# VARS
SOURCE=$HOME/source
COMPONENTS_FOLDER=$PWD/components
mkdir -p $SOURCE
export SOURCE=$SOURCE

APT_GET_PACKAGES="git build-essential autoconf automake libtool pkg-config autopoint bison flex gtk-doc-tools libglib2.0-dev libxml2-dev libogg-dev libvorbis-dev libtheora-dev libv4l-dev v4l-utils liborc-0.4-dev libavformat-dev libavutil-dev libavcodec-dev liba52* libswcale-dev libusb-dev libgusb-dev"
sudo apt-get install $APT_GET_PACKAGES

if [ ! -z "$1" ]
then
	if [ ! -e "$SOURCE/$COMPONENT" ]
	then
		echo "Component '$COMPONENT' does not exist"
	else
		#source $COMPONENTS_FOLDER/$1.sh
		bash $COMPONENTS_FOLDER/$1.sh
	fi
else
	for COMPONENT in `ls components`
	do
		#source $COMPONENTS_FOLDER/$COMPONENT
		bash $COMPONENTS_FOLDER/$COMPONENT
	done
fi
