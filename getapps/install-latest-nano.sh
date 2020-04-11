#!/bin/sh
cd /usr/src
if [ -d nano ]; then
	cd nano
	git pull
else
	git clone git://git.savannah.gnu.org/nano.git nano
	cd nano
fi
sh autogen.sh
./configure && make && make install && make clean
