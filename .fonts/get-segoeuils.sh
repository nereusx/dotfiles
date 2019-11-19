#!/bin/sh
set -e
. ./TTFDIR
#
echo "+ download..."
wget https://github.com/lwilletts/dots/blob/master/fonts/segoeuisl.ttf?raw=true -O segoeuils.ttf
echo "+ copy to system directory"
cp *.ttf $sysdir
echo "+ remove files"
rm -r sego*.ttf
echo "+ update font-cache"
fc-cache
echo "+ done"

