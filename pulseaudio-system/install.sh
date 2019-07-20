#!/bin/sh
#
#	installs system-wide pulseaudio daemon
#

# copy configuration 
ETCDIR=/etc
if [ "$DISTRO" = "FreeBSD" ]; then
	ETCDIR=/usr/local/etc
fi	
cp etc-profile/* $ETCDIR/profile.d/
cp etc-pulse/*   $ETCDIR/pulse/

# build pulse's home directory
mkdir /var/run/pulse
chown pulse:pulse /var/run/pulse

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

elif [ "$DISTRO" = "FreeBSD" ]; then
	echo "=== FreeBSD:"
	echo "run 'pulseaudio --system -D' command and make it work"
	echo
	
# error
else
	echo "unknown service manager"
	exit 1
fi

if [ -e $ETCDIR/asound.conf ]; then
	echo "WARNING: $ETCDIR/asound.conf file found. If you dont know what it is, delete it."
fi
echo "reboot required"
