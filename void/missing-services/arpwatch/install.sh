#!/bin/sh

service=arpwatch

### install binaries
if [ ! -e /usr/sbin/arpwatch ]; then
	xbps-install -Sy arpwatch
fi

### install files
if [ ! -d /var/lib/arpwatch ]; then
	mkdir /var/lib/arpwatch
	touch /var/lib/arpwatch/arp.dat
	cp arpwatch.conf /etc/arpwatch.conf
fi

### install & enable service
svdir=/etc/sv
rtdir=/run/runit
mkdir $svdir/$service
mkdir $rtdir/supervise.$service
cp run /$svdir/$service
ln -svf $rtdir/supervise.$service $svdir/$service/supervise
