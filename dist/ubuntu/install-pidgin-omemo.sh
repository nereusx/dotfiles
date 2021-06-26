#!/bin/tcsh -f

apt install git cmake libpurple-dev libmxml-dev libxml2-dev libsqlite3-dev libgcrypt20-dev build-essential pidgin-dev
cd /usr/src
if ( -d lurch ) then
	cd lurch
	git pull
	git submodule update --init --recursive
else
	git clone https://github.com/gkdr/lurch
	cd lurch
	git submodule update --init --recursive
endif
make clean
make && make install
