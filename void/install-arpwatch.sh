#!/bin/sh

### install binaries
if [ ! -e /usr/sbin/arpwatch ]; then
	xbps-install -Sy arpwatch
fi

### install files
if [ ! -d /var/lib/arpwatch ]; then
	mkdir /var/lib/arpwatch
	cp misc/arpwatch/* /var/lib/arpwatch
fi

grep -w arpwatch /etc/rc.local > /dev/null || echo "(/usr/sbin/arpwatch -d 2>&1 | logger -t ARPWATCH) &" >> /etc/rc.local
