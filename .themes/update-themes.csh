#!/bin/tcsh -f
#
#	Installs or updates themes in user's home directory
#
#	just run it.
#

# the top themes of www.xfce-look.org
# last update: Feb 2019
set list = (\
	https://github.com/horst3180/Arc-theme\
	https://github.com/EliverLara/Sweet.git\
	https://github.com/vinceliuice/Qogir-theme.git\
	https://github.com/paullinuxthemer/Mc-OS-themes\
	https://github.com/bolimage/Ultimate-Maia\
	https://gitlab.com/LinxGem33/X-Arc-White\
	https://github.com/EliverLara/Ant\
	https://github.com/vinceliuice/matcha\
	)

# prepare
set echo_style = both
mkdir ~/.themes >& /dev/null
cd ~/.themes

# download and install or update
foreach repo ( $list )
	set name=$repo:t:r
	echo "\e[1m### $name theme:\e[0m"
	if ( -d $name ) then
		cd $name; git pull; cd ..
	else
		git clone $repo
	endif
	if ( -d $name ) then
		cd $name
		if ( $name == "Ultimate-Maia" ) then
			cp -r Ult* ..
		else if ( $name == "matcha" ) then
			./Install
		else if ( $name =~ "theme-obsidian-2*" ) then
			cp -r Obsidian-2* ..
		else if ( $name =~ "Ant-*" ) then
			cp -r Ant* ..
		endif
		cd ..
	endif
end

echo "\e[1m### done ###\e[0m"

