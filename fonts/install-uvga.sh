#!/bin/sh
set -e
. ./TTFDIR
#
echo "+ download..."
wget http://www.inp.nsk.su/~bolkhov/files/fonts/univga/uni-vga.tgz
echo "+ unzip"
tar xvf uni-vga.tgz
cd uni_vga
bdftopcf u_vga16.bdf -o u_vga16.pcf
gzip u_vga16.pcf
echo "+ copy to system directory"
cp u_vga16.pcf.gz $x11dir
cd ..
echo "+ remove files"
rm uni-vga.tgz
rm -rf uni_vga
echo "+ update font-cache"
fc-cache
echo "+ done"

