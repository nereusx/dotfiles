#!/bin/bash
#set -e
. ./TTFDIR
#
f=oldschool_pc_font_pack_v2.2_linux.zip
echo "+ download..."
wget https://int10h.org/oldschool-pc-fonts/download/$f
echo "+ unzip"
unzip -u $f
rm *.zip
rm -f LICENSE.TXT README.NFO README.TXT UPGRADING.TXT
rm -rf 'otb - Bm (linux bitmap)' docs 'ttf - Mx (mixed outline+bitmap)'
echo "+ uninstall from system directory"
rm -f $sysdir/PxPlus*
rm -f $sysdir/AcPlus*
echo "+ copy to system directory"
for dir in 'ttf - Ac (aspect-corrected)' 'ttf - Px (pixel outline)'; do
	cd "$dir"
	rm *437*
	rm *-2x.*
	rm *x11.*
	rm *x12.*
	rm *x8.*
	rm *CGA*
	rm *EGA*
	rm *BIOS*
	rm *Tandy*
	rm *Amstrad_PC*
	cp ??Plus*.ttf $sysdir
	cd ..
	rm -rf "$dir"
done
echo "+ update font-cache"
fc-cache
echo "+ done"

