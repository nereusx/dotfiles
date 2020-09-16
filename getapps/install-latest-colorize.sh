#!/bin/sh
cd /usr/src
if [ -d colorize ]; then
	cd colorize
	git pull
else
	git clone https://github.com/raszi/colorize
	cd colorize
fi
#[ -x autogen.sh ] && sh autogen.sh
# ./configure && make && make install && make clean
make install
