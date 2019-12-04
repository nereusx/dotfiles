#!/bin/sh
while [ -n "1" ]; do
	notify-send -u low --icon="/usr/share/icons/Papirus/48x48/apps/urxvt.svg" "Fortune files" "$(fortune)"
	sleep 30
done

