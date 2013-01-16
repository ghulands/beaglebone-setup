#!/bin/bash

############################# GSTREAMER CONFIG
GST_SOURCE=$SOURCE/gstreamer
GST_REQUIRED_PROJECTS="gstreamer gst-plugins-base"
GST_OPTIONAL_PROJECTS="gst-ffmpeg gst-plugins-good gst-plugins-ugly gst-plugins-bad"
GST_ALL_PROJECTS="$GST_REQUIRED_PROJECTS $GST_OPTIONAL_PROJECTS"
GST_BRANCH="0.10"
GST_GIT_REPO="git://anongit.freedesktop.org/gstreamer"
GST_INSTALL_PREFIX="/usr/local"

############################# INSTALL GSTREAMER
mkdir -p $GST_SOURCE
cd $GST_SOURCE
echo "Checking out latest source code from $GST_GIT_REPO"

for PROJECT in `echo $GST_ALL_PROJECTS`
do
	if [ ! -e "$GST_SOURCE/$PROJECT" ]
	then
		echo "Virgin checkout of $PROJECT"
		git clone $GST_GIT_REPO/$PROJECT
		cd $PROJECT
		git checkout $GST_BRANCH
		cd ..
	else
		echo "Updating source code for $PROJECT"
		cd $PROJECT
		git pull
		git checkout $GST_BRANCH
		cd ..
	fi
done

echo "Building required projects"
for PROJECT in `echo $GST_REQUIRED_PROJECTS`
do
	echo "Configuring $PROJECT"
	cd $PROJECT
	./autogen.sh --prefix=$GST_INSTALL_PREFIX
	echo "Making $PROJECT"
	make
	echo "Installing $PROJECT"
	sudo make install
	cd ..
done

echo "Configuring GSTREAMER PROJECTS"
for PROJECT in `echo $GST_OPTIONAL_PROJECTS`
do
	echo "Configuring $PROJECT"
	cd $PROJECT
	./autogen.sh --prefix=$GST_INSTALL_PREFIX
	cd ..
done

echo "Building GSTREAMER PROJECTS"
for PROJECT in `echo $GST_OPTIONAL_PROJECTS`
do
	echo "Building $PROJECT"
	cd $PROJECT
	make
	cd ..
done

echo "Installing GSTREAMER PROJECTS"
for PROJECT in `echo $GST_OPTIONAL_PROJECTS`
do
	echo "Building $PROJECT"
	cd $PROJECT
	sudo make install
	cd ..
done
