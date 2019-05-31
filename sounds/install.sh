#!/bin/tcsh -f

set dir=/usr/share/sounds
if ( ! -d $dir ) then
	mkdir $dir
endif
if ( ! -d $dir/generic ) then
	mkdir $dir/generic
endif
cp *.ogg $dir/generic
