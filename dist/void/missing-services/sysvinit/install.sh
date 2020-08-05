#!/bin/sh

# executes all executables scripts /etc/rc.d/rc.*
service=sysvinit

###
svdir=/etc/sv
rtdir=/run/runit
mkdir $svdir/$service
mkdir $rtdir/supervise.$service
cp run /$svdir/$service
cp finish /$svdir/$service
ln -svf $rtdir/supervise.$service $svdir/$service/supervise
