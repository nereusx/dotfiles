#!/bin/sh

prog=ccze
desc="\
This is CCZE, a fast log colorizer written in C, intended to be a\
drop-in replacement for colorize (http://colorize.raszi.hu).\
"
repo=https://github.com/cornet/$prog
webp=http://bonehunter.rulez.org/CCZE.html

######
[ "$1" = "-i" ] && { echo "# $prog\n\n$desc\n\nHome-page: $webp\nRepository: $webp"; exit; }

cd /usr/src
if [ -d $prog ]; then
	cd $prog
	git pull
else
	git clone $repo
	cd $prog
fi
./configure && make && make install && make clean && echo "\n\033[32mdone\033[0m" || echo "\n\033[1;31mfailed\033[0m"


