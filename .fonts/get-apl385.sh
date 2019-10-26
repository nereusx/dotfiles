#!/bin/sh
set -e
. ./TTFDIR
#
echo "+ download..."
wget https://apl385.com/fonts/apl385.zip
echo "+ unzip"
unzip apl385.zip
echo "+ copy to system directory"
cp *.ttf $sysdir
echo "+ remove files"
rm *.ttf *.zip
echo "+ update font-cache"
fc-cache
echo "+ done"

