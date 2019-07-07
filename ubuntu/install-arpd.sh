#!/bin/sh

### install binaries
if [ ! -e /usr/sbin/arpd ]; then
	apt install iproute2
fi

### install files
if [ ! -d /var/lib/arpd ]; then
	mkdir /var/lib/arpd
fi

grep -w arpd /etc/rc.local > /dev/null || echo "/usr/sbin/arpd" >> /etc/rc.local
