#!/bin/tcsh -f
#
#	Installs or updates icon-thems in user's home directory
#
#	just run it.
#

# themes from www.xfce-look.org
# last update: Feb 2019
set list = (\
	https://github.com/bolimage/Ultimate-Maia-Icons\
	https://github.com/zayronxio/Zafiro-icons\
	https://gitlab.com/froodo_alexis/Antu-icons\
	)

# prepare
set echo_style = both
mkdir ~/.icons >& /dev/null
cd ~/.icons

# download and install or update
foreach repo ( $list )
	set name=$repo:t:r
	echo "\e[1m### $name theme:\e[0m"
	if ( -d $name ) then
		cd $name; git pull; cd ..
	else
		git clone $repo
	endif
end

echo "\e[1m### done ###\e[0m"

