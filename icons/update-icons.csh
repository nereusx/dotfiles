#!/bin/tcsh -f
#
#	Installs or updates icon-thems in user's home directory
#
#	just run it.
#

# themes from www.xfce-look.org
# last update: Feb 2019
set list = (\
	https://github.com/zayronxio/Zafiro-icons\
	https://gitlab.com/froodo_alexis/Antu-icons\
	)

# prepare
set echo_style = both

# download and install or update
foreach repo ( $list )
	set name=$repo:t:r
	echo "\e[1m### $name theme:\e[0m"
	if ( -d $name ) then
		cd $name; git pull; cd ..
	else
		git clone $repo
	endif
	gtk-update-icon-cache "$name"
end

# papirus
if ( -X apt-get ) then
	set ppa=papirus
	if ( ! { grep -q "^deb .*$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/* } ) then
		sudo add-apt-repository ppa:papirus/papirus
		sudo apt-get update
		sudo apt-get install papirus-icon-theme
	endif
else
	sudo wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install.sh | sh
endif

echo "\e[1m### done ###\e[0m"

