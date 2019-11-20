#!/bin/sh
set -e
. ./TTFDIR
#
echo "+ download..."
wget https://www.kutilek.de/download/sudo.zip
echo "+ unzip"
unzip sudo.zip
echo "+ copy to system directory"
cd sudo
cp *.ttf $sysdir
cd ..
echo "+ remove files"
rm -r sudo
rm sudo.zip
echo "+ update font-cache"
fc-cache
echo "+ done"

