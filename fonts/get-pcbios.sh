#!/bin/sh
set -e
. ./TTFDIR
#
echo "+ download..."
wget https://int10h.org/oldschool-pc-fonts/download/ultimate_oldschool_pc_font_pack_v1.0.zip
echo "+ unzip"
unzip ultimate_oldschool_pc_font_pack_v1.0.zip
echo "+ copy to system directory"
cd 'PxPlus (TrueType - extended charset)'
rm *-2x*
cp *VGA*.ttf $sysdir
cd ..
echo "+ remove files"
rm *.zip
rm -r 'Bm437 (Windows bitmap)'
rm -r 'Px437 (TrueType - DOS charset)'
rm -r 'PxPlus (TrueType - extended charset)'
rm LICENSE.TXT README.NFO
echo "+ update font-cache"
fc-cache
echo "+ done"

