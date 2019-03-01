#!/bin/tcsh -f

if ( -d ~/.xres ) then
	rm ~/.Xresources
	foreach f ( ~/.xres/*.res )
		cat $f >> ~/.Xresources
	end
	echo -n "${HOME}/.Xresources created"
	if ( $?DISPLAY ) then
		if ( { xrdb -merge ~/.Xresources } ) then
			echo -n " and merged"
		else
			echo -n ", but NOT merged"
		endif
	endif
	echo .
else
	echo "~/.xres does not exists"
endif
