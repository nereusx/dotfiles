#!/bin/tcsh

set list = ( /usr/share/icons /usr/share/pixmaps /usr/local/share/icons )
foreach e ( $list )
	if ( -d $e ) then
		cp *.png $e
		exit 0
	endif
end
echo "no suitable directory found"
exit 1
