#!/bin/sh

dirx="unix-utils"
repo="https://github.com/nereusx/$dirx"

cd /usr/src
if [ -d $dirx ]; then
	cd $dirx
	git pull
else
	git clone $repo
	cd $dirx
fi
./install.sh

