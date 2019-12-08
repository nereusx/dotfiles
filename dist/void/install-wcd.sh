#!/bin/sh

prog=wcd
desc=`cat <<EOT
This is CCZE, a fast log colorizer written in C, intended to be a
drop-in replacement for colorize (http://colorize.raszi.hu).
EOT`
zpkg=wcd-6.0.3.tar.gz
zdir=wcd-6.0.3
zurl=https://waterlan.home.xs4all.nl/wcd/$zpkg
webp=https://waterlan.home.xs4all.nl/

######
msgdone() { echo "\n\033[1;32mdone\033[0m"; }
msgfail() { echo "\n\033[1;31mfailed\033[0m"; }
msginfo() { echo "# \033[1m$prog\033[0m\n\n$desc\n\nHome-page : \033[4m$webp\033[0m\nRepository: \033[4m$repo\033[0m"; }
[ "$1" = "-i" ] && { msginfo; exit; }

cd /usr/src
[ -f $zpkg ] && rm $zpkg
wget $zurl
cd $zdir
make && make install && make clean && msgdone || msgfail


