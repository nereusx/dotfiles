#!/bin/sh

prog=wcd
desc=`cat <<EOT
Wcd is a command-line program to change directory fast.
It saves time typing at the keyboard.
One needs to type only a part of a directory name and wcd will jump to it.
Wcd has a fast selection method in case of multiple matches and allows aliasing and banning of directories.
Wcd also includes a full screen interactive directory tree browser with speed search. 
EOT`
zpkg=wcd-6.0.3.tar.gz
zdir=wcd-6.0.3
zurl=https://waterlan.home.xs4all.nl/wcd/$zpkg
webp=https://waterlan.home.xs4all.nl/
repo=$zurl

######
msgdone() { echo "\n\033[1;32mdone\033[0m"; }
msgfail() { echo "\n\033[1;31mfailed\033[0m"; }
msginfo() { echo "# \033[1m$prog\033[0m\n\n$desc\n\nHome-page : \033[4m$webp\033[0m\nRepository: \033[4m$repo\033[0m"; }
msgminf() { echo "name=$prog\nhome=$webp\nrepo=$repo\ndesc:\n$desc\nEOT"; }
[ "$1" = "-i" ] && { msginfo; exit; }
[ "$1" = "-m" ] && { msgminf; exit; }

cd /usr/src
[ -f $zpkg ] && rm $zpkg
wget $zurl
cd $zdir
make && make install && make clean && msgdone || msgfail


