#!/bin/sh
#
#	installs system-wide pulseaudio daemon
#

# copy configuration files
cp etc-profile/* /etc/profile.d/
cp etc-pulse/*   /etc/pulse/

# enable service

# runit - void
if [ -x /usr/bin/runit ]; then
	if [ ! -d /etc/sv/pulseaudio ]; then
		cp -r runit/* /etc/sv/
		mkdir /run/runit/supervise.pulseaudio
	fi
	ln -svf /etc/sv/pulseaudio /var/service/pulseaudio

# sysv - slackware
elif [ -f /etc/rc.d/rc.pulseaudio ]; then
	chmod +x /etc/rc.d/rc.pulseaudio
	/etc/rc.d/rc.pulseaudio restart

# systemd - ubuntu
elif [ -x /usr/bin/systemctl ]; then
	cp systemd/pulseaudio-system.service /etc/systemd/system/
	systemctl enable pulseaudio-system

# error
else
	echo "unknown service manager"
	exit 1
fi

echo "reboot required"
