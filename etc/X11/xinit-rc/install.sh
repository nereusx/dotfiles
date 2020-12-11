#!/bin/sh
dest_bin=/usr/local/bin

xdir=$(dirname $PWD)
sdir=$(basename $PWD)

if [ ! "$xdir" = "/etc/X11" ]; then
	echo "copy configs to /etc/X11/$sdir"
	cp -rf ../$sdir /etc/X11/
fi
echo "copy xwmlist and {update-}xwmconfig to $dest_bin"
cp xwmlist   $dest_bin
cp xwmconfig $dest_bin
cp update-xwmconfig $dest_bin

