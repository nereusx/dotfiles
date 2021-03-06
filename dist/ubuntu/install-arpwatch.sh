#!/bin/sh

### install binaries
if [ ! -e /usr/sbin/arpwatch ]; then
	apt install arpwatch
fi

### install files
if [ ! -d /var/lib/arpwatch ]; then
	mkdir /var/lib/arpwatch
	cp misc/arpwatch/* /var/lib/arpwatch
fi

### add it to rc.local
grep -w arpwatch /etc/rc.local > /dev/null || echo "(/usr/sbin/arpwatch -d 2>&1 | logger -t ARPWATCH) &" >> /etc/rc.local
