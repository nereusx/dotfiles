#!/bin/sh
set -e
. ./TTFDIR
#
echo "+ download..."
wget https://github.com/be5invis/Iosevka/releases/download/v2.3.2/02-iosevka-term-2.3.2.zip
echo "+ unzip"
unzip 02-iosevka-term-2.3.2.zip
echo "+ copy to system directory"
cp ttf/*.ttf $sysdir
echo "+ remove files"
rm *.zip *.charmap *.css
rm -r ttf ttf-unhinted woff woff2
echo "+ update font-cache"
fc-cache
echo "+ done"

