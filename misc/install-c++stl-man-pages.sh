#!/bin/sh
#
#	C++ STL man pages
#
cd /usr/src
if [ -d stdman ]; then
	cd stdman
	git pull
else
	git clone https://github.com/jeaye/stdman
	cd stdman
fi
./configure --prefix=/usr
make install
