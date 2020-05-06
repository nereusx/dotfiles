#!/bin/sh

echo "Feather - Icons"

set -e
. ./TTFDIR
#
echo "+ download..."
wget https://github.com/adi1090x/rofi/raw/master/fonts/feather.ttf
echo "+ copy to system directory"
mv feather.ttf $x11dir
[ -f feather.ttf ] && rm feather.ttf
echo "+ update font-cache"
fc-cache
echo "+ done"

