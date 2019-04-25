#!/bin/tcsh -f

set list = (\
	https://github.com/agarick/agave\
	https://github.com/nereusx/xsg-fonts\
	https://github.com/wlifferth/paragon\
	)

# system installation
set install_to_system
set dest_ttf = /usr/share/fonts/TTF
if ( ! -d $dest_ttf ) set dest_ttf = /usr/share/fonts/truetype	
set dest_otf = /usr/share/fonts/OTF
if ( ! -d $dest_otf ) set dest_otf = /usr/share/fonts/opentype	
set dest_pcf = /usr/share/fonts/misc
if ( ! -d $dest_pcf ) set dest_pcf = /usr/share/fonts/X11/misc

# prepare
set echo_style = both
mkdir ~/.fonts >& /dev/null
cd ~/.fonts

# download
foreach repo ( $list )
        set name=$repo:t:r
        echo "\e[1m### $name font:\e[0m"
        if ( -d $name ) then
                cd $name; git pull; cd ..
        else
                git clone $repo
        endif
end
#wget https://github.com/be5invis/Iosevka/releases/latest

# system install
if ( $?install_to_system ) then
	if ( -e /etc/fonts/conf.d/70-no-bitmaps.conf ) then
		sudo rm /etc/fonts/conf.d/70-no-bitmaps.conf
	endif
	if ( ! -e /etc/fonts/conf.d/70-yes-bitmaps.conf ) then
		if ( -e /etc/fonts/conf.avail/70-yes-bitmaps.conf ) then
			sudo ln -s /etc/fonts/conf.avail/70-yes-bitmaps.conf /etc/fonts/conf.d/70-yes-bitmaps.conf
		endif
	endif
	sudo find . -iname "*.ttf" -exec install -m 0644 -o root -g root \{\} $dest_ttf \;
	sudo find . -iname "*.otf" -exec install -m 0644 -o root -g root \{\} $dest_otf \;
	sudo find . -iname "*.pcf.gz" -exec install -m 0644 -o root -g root \{\} $dest_pcf \;
	sudo fc-cache -rsvf
endif
