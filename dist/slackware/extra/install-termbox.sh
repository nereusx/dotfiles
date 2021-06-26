#!/bin/sh

cd /usr/src
if [ -d termbox ]; then
	cd termbox
	git pull
else
	git clone https://github.com/nsf/termbox
	cd termbox
fi
./waf configure --prefix=/usr
./waf
./waf install --destdir=DESTDIR
