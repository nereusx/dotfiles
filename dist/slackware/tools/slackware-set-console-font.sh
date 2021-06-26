#!/bin/sh

if [ $(id -u) -gt 0 ]; then
	echo "$0: must be superuser."
	exit 1
fi
if [ $# -eq 0 ]; then
	echo "usage: slackware-scet-console-font.sh fontname"
	exit 1
fi

dir=/usr/share/kbd/consolefonts
fontbase="$1"
font=$fontbase

if [ -e $dir/$fontbase.gz ]; then
	font=$fontbase.gz
elif [ -e $dir/$fontbase.cp.gz ]; then
	font=$fontbase.cp.gz
elif [ -e $dir/$fontbase.fnt.gz ]; then
	font=$fontbase.fnt.gz
elif [ -e $dir/$fontbase.psf.gz ]; then
	font=$fontbase.psf.gz
elif [ -e $dir/$fontbase.psfu.gz ]; then
	font=$fontbase.psfu.gz
fi

if [ ! -e $dir/$font ]; then
	echo "$font does not exist"
	exit 1
fi

# everything is ready... backup previous font
if [ -L $dir/default8x16.psfu.gz ]; then
	rm $dir/default8x16.psfu.gz
else
	if [ -e $dir/default8x16.psfu.gz ]; then
		mv $dir/default8x16.psfu.gz $dir/default8x16-original.psfu.gz
	fi
fi

# link default to new font
ln -s $dir/$font $dir/default8x16.psfu.gz
#ls -la $dir/default8x16-original.psfu.gz
#ls -la $dir/default8x16.psfu.gz

