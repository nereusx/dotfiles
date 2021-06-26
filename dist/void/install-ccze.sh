#!/bin/sh

prog=ccze
desc=`cat <<EOT
This is CCZE, a fast log colorizer written in C, intended to be a
drop-in replacement for colorize (http://colorize.raszi.hu).
EOT`
repo=https://github.com/cornet/$prog
webp=http://bonehunter.rulez.org/CCZE.html

######
msgdone() { echo "\n\033[1;32mdone\033[0m"; }
msgfail() { echo "\n\033[1;31mfailed\033[0m"; }
msginfo() { echo "# \033[1m$prog\033[0m\n\n$desc\n\nHome-page : \033[4m$webp\033[0m\nRepository: \033[4m$repo\033[0m"; }
msgminf() { echo "name=$prog\nhome=$webp\nrepo=$repo\ndesc:\n$desc\nEOT"; }
[ "$1" = "-i" ] && { msginfo; exit; }
[ "$1" = "-m" ] && { msgminf; exit; }

cd /usr/src
if [ -d $prog ]; then
	cd $prog
	git pull
else
	git clone $repo
	cd $prog
fi
./configure && make && make install && make clean && msgdone || msgfail


