#!/bin/tcsh

set list = ( /usr/share/wallpapers /usr/share/backdrops )
foreach e ( $list )
	if ( -d $e ) then
		cp *.png $e
		break;
	endif
end
