#!/bin/sh
cd /usr/src
if [ -d ccze ]; then
	cd ccze
	git pull
else
	git clone https://github.com/cornet/ccze
	cd ccze
fi
./configure --prefix=/usr && make && make install && make clean
