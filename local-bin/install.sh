#!/bin/tcsh -f

set dest=/usr/local/bin
if ( ! -d $dest ) then
	mkdir -p $dest
	chown root:root $dest
	chmod 0755 $dest
endif
if ( "$1" == "-s" ) then
	foreach f ( * )
		if ( $f != "install.sh" ) then
			if ( -e "$dest/$f" ) then
				rm "$dest/$f"
			endif
			ln -svf "$PWD/$f" "$dest/$f"
		endif
	end
else
	foreach f ( * )
		if ( $f != "install.sh" ) then
			if ( -l "$dest/$f" ) then
				rm "$dest/$f"
			endif
			cp "$PWD/$f" "$dest/$f"
		endif
	end
endif

