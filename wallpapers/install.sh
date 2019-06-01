#!/bin/tcsh

set list = ( /usr/share/wallpapers /usr/share/backdrops /usr/share/backgrounds /usr/local/share/backgrounds )
foreach e ( $list )
	if ( -d $e ) then
		cp *.png $e
		exit 0
	endif
end
set e=/usr/local/share/backgrounds
mkdir -p $e
cp *.png $e
