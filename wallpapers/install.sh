#!/bin/tcsh

set list = ( /usr/share/wallpapers /usr/share/backdrops /usr/share/backgrounds /usr/local/share/backgrounds )
foreach e ( $list )
	if ( -d $e ) then
		cp *.png $e
		exit 0
	endif
end
echo "no suitable directory found"
exit 1
