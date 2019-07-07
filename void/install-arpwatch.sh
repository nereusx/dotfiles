#!/bin/sh

### install binaries
if [ ! -e /usr/sbin/arpwatch ]; then
	xbps-install -Sy arpwatch
fi

### install files
if [ ! -d /var/lib/arpwatch ]; then
	mkdir /var/lib/arpwatch
	touch /var/lib/arpwatch/arp.dat
	touch /var/lib/arpwatch/arp.dat-
	cp etc/arpwatch.conf /etc/arpwatch.conf
fi

grep arpwatch /etc/rc.local > /dev/null || echo "/usr/sbin/arpwatch" >> /etc/rc.local
