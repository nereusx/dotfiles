#!/bin/sh
app=./ubuntu-pkg
$app -i avahi-utils avahi-ui-utils avahi-dnsconfd avahi-daemon
cp -r etc/avahi/* /etc/avahi/
$app -e avahi-daemon avahi-dnsconfd
