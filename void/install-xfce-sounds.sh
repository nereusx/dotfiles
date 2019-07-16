#!/bin/sh
app=./void-pkg
# there are no sound-themes
$app -i libcanberra-gtk xfce4-settings xsettingsd xfconf libcanberra-utils

cp etc/profile.d/gtk-sound-module.sh /etc/profile.d/
xfconf-query -c xsettings -p /Net/SoundThemeName -s ubuntu

# unzip sound theme
unzip ubuntu-sound-theme.zip -d /

echo "you need to reboot to enable XFCE4 sounds"
