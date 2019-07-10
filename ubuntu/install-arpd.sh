#!/bin/sh

### install binaries
if [ ! -e /usr/sbin/arpd ]; then
	apt install iproute2
fi

### install files
if [ ! -d /var/lib/arpd ]; then
	mkdir /var/lib/arpd
fi

### add it to /etc/rc.local
grep -w arpd /etc/rc.local > /dev/null || echo "/usr/sbin/arpd" >> /etc/rc.local

### run it
pgrep -u root -x arpd > /dev/null || arpd

echo "* get report: arpd -l *"
