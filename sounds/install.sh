#!/bin/tcsh -f

set dir=/usr/share/sounds
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
