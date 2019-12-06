#!/bin/sh

cd /usr/src
if [ -d fzy ]; then
	cd fzy
	git pull
else
	git clone https://github.com/jhawthorn/fzy
	cd fzy
fi
make && make install && make clean && echo -e "\ndone" || echo -e "\n\033[31mfailed\033[0m"

