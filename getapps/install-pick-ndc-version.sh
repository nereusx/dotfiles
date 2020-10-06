#!/bin/sh

dirx="npick"
repo="https://github.com/nereusx/$dirx"

cd /usr/src
if [ -d $dirx ]; then
	cd $dirx
	git pull
else
	git clone $repo
	cd $dirx
fi
./configure && make && make install && make clean && echo -e "\ndone" || echo -e "\n\033[31mfailed\033[0m"

