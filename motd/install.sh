#!/bin/sh
DIR=$PWD
cp $DIR/sbin/motd-create         /usr/local/sbin/motd-create
cp $DIR/sbin/motd-add            /usr/local/sbin/motd-add
cp $DIR/daily/motd-daily-update  /etc/cron.daily/motd-daily-update
