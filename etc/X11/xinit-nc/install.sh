#!/bin/sh
xdir=$(dirname $PWD)
if [ ! "$xdir" = "/etc/X11" ]; then
	echo "copy configs to /etc/X11/xinit-nc"
	cp -rf ../xinit-nc /etc/X11/
fi
echo "copy xwmlist and xwmconfig to /usr/local/bin"
cp xwmlist   /usr/local/bin
cp xwmconfig /usr/local/bin
