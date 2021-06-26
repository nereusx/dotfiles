#!/bin/sh
exe=/usr/sbin/sbopkg
if [ ! -x $exe ]; then
	installpkg packages/sbopkg*
fi
$exe -u
$exe -r
