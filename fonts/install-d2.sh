#!/bin/sh
set -e
. ./TTFDIR
#
echo "+ download..."
wget 'https://github.com/naver/d2codingfont/raw/master/D2Coding-Ver1.3.2-20180524.zip' -O d2.zip
echo "+ unzip"
unzip d2.zip
echo "+ copy to system directory"
cp D2Coding/D2Coding* $sysdir
echo "+ update font-cache"
fc-cache
echo "+ cleanup"
rm -f d2.zip
rm -rf D2Coding*
echo "+ done"

