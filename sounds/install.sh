#!/bin/tcsh -f

if ( $OSTYPE =~ "*BSD" ) then
	set dir=/usr/local/share/sounds
else
	set dir=/usr/share/sounds
endif

set list = ( /usr/share/sounds /usr/local/share/sounds )
foreach e ( $list )
	if ( -d $e ) then
		set dir="$e"
	endif
end

if ( ! -d $dir ) then
	mkdir $dir
endif
if ( ! -d $dir/generic ) then
	mkdir $dir/generic
endif
cp *.ogg $dir/generic
