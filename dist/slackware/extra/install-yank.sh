#!/bin/sh

cd /usr/src
if [ -d yank ]; then
	cd yank
	git pull
else
	git clone https://github.com/mptre/yank
	cd yank
fi
make && make install && make clean && echo -e "\ndone" || echo -e "\n\033[31mfailed\033[0m"

