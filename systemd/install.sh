#!/bin/sh
for f in rc.*; do
	cp $f /etc
done
for f in *.service; do
	if [ -e /etc/systemd/system/$f ]; then
		systemctl stop $f
		systemctl disable $f
	fi
	cp $f /etc/systemd/system
	systemctl enable $f
done
systemctl daemon-reload
