#!/bin/tcsh
if ( -z "$GTK_MODULES" ) then
	setenv GTK_MODULES "canberra-gtk-module"
else
	setenv GTK_MODULES "$GTK_MODULES:canberra-gtk-module"
endif

