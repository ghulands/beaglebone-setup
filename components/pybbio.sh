#!/bin/bash

############################# PyBBIO CONFIG
PYBBIO_SOURCE=$SOURCE/PyBBIO
PYBBIO_GIT_REPO="git://github.com/alexanderhiam/PyBBIO.git"

############################# Install PyBBIO
echo "Installing PyBBIO from $PYBBIO_GIT_REPO"
cd $SOURCE

if [ ! -e "$PYBBIO_SOURCE" ]
then
	echo "Virgin checkout of PyBBIO"
	git clone $PYBBIO_GIT_REPO
else
	cd $PYBBIO_SOURCE
	git pull
	cd ..
fi

cd $PYBBIO_SOURCE
sudo setup.py install
cd ..	