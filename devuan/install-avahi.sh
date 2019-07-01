#!/bin/sh
app=./deb-pkg
$app -i avahi-utils avahi-ui-utils avahi-dnsconfd avahi-daemon
cp etc/avahi/* /etc/avahi/
$app -e avahi-daemon avahi-dnsconfd
