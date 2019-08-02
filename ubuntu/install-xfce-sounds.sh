#!/bin/sh
apt install libcanberra-pulse libcanberra-gtk-module gnome-session-canberra xfce4-settings xsettingsd xfconf ubuntu-sounds
cp etc/profile.d/gtk-sound-module.sh /etc/profile.d/
xfconf-query -c xsettings -p /Net/SoundThemeName -s ubuntu
echo "you need to reboot to enable XFCE4 sounds"
