#!/bin/sh

dirx=project
repo=https://github.com/user/$dirx

#
cd /usr/src
if [ -d $dirx ]; then
	cd $dirx
	git pull
else
	git clone $repo
	cd $dirx
fi

if [ -x install.sh ]; then
	./install.sh
elif [ -x autogen.sh ]; then
	sh autogen.sh && ./configure && make && make install && make clean
elif [ -x configure ]; then
	./configure && make && make install && make clean
elif [ -f Makefile -o -f GNUmakefile ]; then
	make && make install && make clean
else
	echo "I don't know how to install it."
	exit 1
fi

