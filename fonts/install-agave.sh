#!/bin/sh
set -e
. ./TTFDIR
#
echo "+ download..."
wget "https://github.com/agarick/agave/blob/master/dist/Agave-Regular.ttf?raw=true" -O Agave-Regular.ttf
echo "+ copy to system directory"
mv Agave-Regular.ttf $sysdir
echo "+ update font-cache"
fc-cache
echo "+ done"

