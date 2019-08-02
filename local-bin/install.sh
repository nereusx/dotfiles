#!/bin/tcsh -f

set dest=/usr/local/bin
if ( ! -d $dest ) then
	mkdir -p $dest
	chown root:root $dest
	chmod 0750 $dest
endif
if ( "$1" == "-s" ) then
	foreach f ( * )
		if ( $f:e == "" ) then
			if ( -e "$dest/$f" ) then
				rm "$dest/$f"
			endif
			ln -svf "$PWD/$f" "$dest/$f"
		endif
	end
else
	foreach f ( * )
		if ( $f:e == "" ) then
			if ( -l "$dest/$f" ) then
				rm "$dest/$f"
			endif
			cp $f "$dest/$f"
		endif
	end
endif

