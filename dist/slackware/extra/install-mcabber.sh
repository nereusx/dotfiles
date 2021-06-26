#!/bin/sh

cd /usr/src
if [ -d mcabber ]; then
	cd mcabber
	git pull
else
	git clone https://github.com/McKael/mcabber
	cd mcabber
fi
cd mcabber
./autogen.sh
./configure && make && make install && make clean && echo -e "\ndone" || echo -e "\n\033[31mfailed\033[0m"

