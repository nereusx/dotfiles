#!/bin/sh

prog=ccze
repo=https://github.com/cornet/$prog

##
cd /usr/src
if [ -d $prog ]; then
	cd $prog
	git pull
else
	git clone $repo
	cd $prog
fi
./configure && make && make install && make clean && echo "\033[32mdone\033[0m" || echo "\033[1;31mfailed\033[0m"


