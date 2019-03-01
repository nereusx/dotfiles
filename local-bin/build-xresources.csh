#!/bin/tcsh -f

if ( -d ~/.xres ) then
	rm ~/.Xresources
	foreach f ( ~/.xres/*.res )
		cat $f >> ~/.Xresources
	end
	if ( $?DISPLAY ) then
		xrdb -merge ~/.Xresources
	endif
	echo "done"
else
	echo "~/.xres does not exists"
endif
