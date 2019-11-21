#!/bin/sh
set -e
. ./TTFDIR
#
echo "+ download..."
wget "https://raw.githubusercontent.com/ProgrammingFonts/ProgrammingFonts/master/Monofur/monofur-1.0/monofur-regular.ttf"
wget "https://raw.githubusercontent.com/ProgrammingFonts/ProgrammingFonts/master/Monofur/monofur-1.0/monofur-italic.ttf"
echo "+ copy to system directory"
cp *.ttf $sysdir
echo "+ remove files"
rm *.ttf 
echo "+ update font-cache"
fc-cache
echo "+ done"

