#!/bin/sh

cd /usr/src
if [ -d pick ]; then
	cd pick
	git pull
else
	git clone https://github.com/mptre/pick
	cd pick
fi
./configure && make && make install && make clean && echo -e "\ndone" || echo -e "\n\033[31mfailed\033[0m"

