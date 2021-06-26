#!/bin/sh
#
#	C app to colorize log files,
#	need patch, something make it slow
#
cd /usr/src
if [ -d ccze ]; then
	cd ccze
	git pull
else
	git clone https://github.com/cornet/ccze
	cd ccze
fi
./configure --prefix=/usr && make && make install && make clean
