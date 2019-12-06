#!/bin/sh
pkg="lrzsz-0.12.20.tar.gz"

cd /usr/src
if [ ! -e $pkg ]; then
	wget https://ohse.de/uwe/releases/$pkg
	tar xvf $pkg
	cd lrzsz
	make
	make install
	# need second time, bug in Makefile
	make install
fi

