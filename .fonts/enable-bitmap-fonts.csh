#!/bin/tcsh -f
if ( -e /etc/fonts/conf.d/70-no-bitmaps.conf ) then
	sudo rm /etc/fonts/conf.d/70-no-bitmaps.conf
endif
if ( ! -e /etc/fonts/conf.d/70-yes-bitmaps.conf ) then
	if ( -e /etc/fonts/conf.avail/70-yes-bitmaps.conf ) then
		sudo ln -s /etc/fonts/conf.avail/70-yes-bitmaps.conf /etc/fonts/conf.d/70-yes-bitmaps.conf
	endif
endif

