#!/bin/sh
#
#	xclip is a command-line interface for xclipboard
#
sbo=/usr/sbin/sbopkg
[ -x $sbo ] || ./install-sbopkg.sh

if [ -x $sbo ]; then
	$sbo -B -i xclip
fi
