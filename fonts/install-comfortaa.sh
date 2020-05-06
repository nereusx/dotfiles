#!/bin/sh
set -e
. ./TTFDIR
#
echo "+ download..."
wget "https://dl.dafont.com/dl/?f=comfortaa" -O comfortaa.zip
echo "+ unzip"
unzip comfortaa.zip -d comfortaa
echo "+ copy to system directory"
cd comfortaa
cp *.ttf $x11dir
cd ..
echo "+ remove files"
rm -rf comfortaa
rm comfortaa.zip
echo "+ update font-cache"
fc-cache
echo "+ done"

