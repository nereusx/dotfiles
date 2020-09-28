#!/bin/sh

dirx=qb64
repo=https://github.com/QB64Team/$dirx

#
if [ "$USER" = "root" ]; then
	echo "You have to run this as regular user; it is QB64's limitation"
	exit 1
fi

#
cd /usr/src
if [ -d $dirx ]; then
	cd $dirx
	git pull
else
	git clone $repo
	cd $dirx
fi
#sh autogen.sh
#./configure && make && make install && make clean
./setup_lnx.sh
