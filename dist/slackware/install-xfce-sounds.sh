#!/bin/sh

cd /usr/src
if [ ! -f /usr/lib64/libcanberra-pulse.so ]; then
	if [ -d libcanberra ]; then
		cd libcanberra
		git pull
	else
		git clone git://git.0pointer.de/libcanberra
		cd libcanberra
	fi
	./autogen.sh
	./configure --prefix=/usr --disable-oss
	make && make install
	ldconfig
fi

cp etc/profile.d/gtk-sound-module.* /etc/profile.d/
xfconf-query -c xsettings -p /Net/SoundThemeName -s ubuntu

# added to sounds/sound-themes
## unzip sound theme
#unzip ubuntu-sound-theme.zip -d /

echo
echo "you need to reboot to enable XFCE4 sounds"
