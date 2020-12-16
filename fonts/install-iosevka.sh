#!/bin/sh
VER=3.6.3
set -e
. ./TTFDIR
#
packages="pkg-iosevka pkg-iosevka-slab"
for pkg in $packages; do
	echo "+ download... $pkg"
	wget https://github.com/be5invis/Iosevka/releases/download/v${VER}/${pkg}-${VER}.zip
	echo "+ unzip"
	unzip ${pkg}-${VER}.zip
	echo "+ copy to system directory"
	cp ttf/*-fixed-*.ttf $sysdir
	echo "+ remove files"
	rm *.zip *.css
	rm -r ttf ttc ttf-unhinted woff woff2
done
echo "+ update font-cache"
fc-cache
echo "+ done"

