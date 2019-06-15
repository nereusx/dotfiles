#!/bin/sh

service=avahi-dnsconfd

###
svdir=/etc/sv
rtdir=/run/runit
mkdir $svdir/$service
mkdir $rtdir/supervise.$service
cp run /$svdir/$service
ln -svf $rtdir/supervise.$service $svdir/$service/supervise
