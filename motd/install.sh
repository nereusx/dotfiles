#!/bin/sh
DIR=$PWD
ln -svf $DIR/sbin/motd-create         /usr/local/sbin/motd-create
ln -svf $DIR/sbin/motd-add            /usr/local/sbin/motd-add
ln -svf $DIR/daily/motd-daily-update  /etc/cron.daily/motd-daily-update
