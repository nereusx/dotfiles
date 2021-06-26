#!/bin/sh
dirx=nano
repo=git://git.savannah.gnu.org/$dirx.git

cd /usr/src
if [ -d $dirx ]; then
	cd $dirx
	git pull
else
	git clone $repo $dirx
	cd $dirx
fi
sh autogen.sh
./configure && make && make install && make clean
