#!/bin/bash
#
#	installs system-wide pulseaudio daemon
#
#	1. there will be one sound server for the whole system, yeah!
#	2. all users in pulse-access group could use the sound server
#	3. you can use sounds/speech in scripts, notification, warnings etc
#

# find distro
if [ -f /etc/os-release ]; then
	. /etc/os-release
	DISTRO=${ID:-$NAME}
	OSTYPE=${OSTYPE:-$(uname -s)}
else
	DISTRO="$(uname -o)"
	OSTYPE=${OSTYPE:-$(uname -s)}
fi

# copy configuration 
ETCDIR=/etc
if [ "$DISTRO" = "FreeBSD" ]; then
	ETCDIR=/usr/local/etc
fi	
cp etc-profile/* $ETCDIR/profile.d/
cp etc-pulse/*   $ETCDIR/pulse/

# pulse user
#username="pulse"
#if [ `sed -n "/^$username/p" /etc/passwd` ]; then
#	echo "User [$username] already exists"
#else
#	echo "User [$username] doesn't exist"
#	useradd pulse -g pulse
#fi

# When PulseAudio starts in the system mode, it will change its user and group from root to pulse
# in order to not have too many privileges. The pulse user needs to be in the audio and bluetooth
# groups in order to be able to use ALSA and bluetooth devices.
usermod -aG audio pulse
usermod -aG bluetooth pulse

# All users that need access to PulseAudio have to be in the pulse-access group, even root. 
usermod -aG pulse-access root

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
elif [ $(which systemctl 2> /dev/null ) ]; then
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
