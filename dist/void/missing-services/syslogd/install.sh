#!/bin/sh

# the original small syslogd (package: inetutils-syslogd)

service=syslogd

###
svdir=/etc/sv
rtdir=/run/runit
mkdir $svdir/$service
mkdir $rtdir/supervise.$service
cp run /$svdir/$service
cp conf /$svdir/$service
new=""
[ ! -f /etc/syslogd ] && new=".new"
cp etc-default/syslogd /etc/syslogd$new
[ ! -d /etc/syslog.d ] && mkdir /etc/syslog.d
ln -svf $rtdir/supervise.$service $svdir/$service/supervise
