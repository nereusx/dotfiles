#!/bin/sh

DIR=$PWD

# scripts
cp -r $DIR/etc/motd.d /etc/

# commands
cp $DIR/sbin/motd-create         /usr/local/sbin/motd-create
cp $DIR/sbin/motd-add            /usr/local/sbin/motd-add

# cron
cp $DIR/daily/motd-daily-update  /etc/cron.daily/motd-daily-update

# find startup script
if [ -w /etc/rc.d/rc.local ]; then
	RCLOCAL="/etc/rc.d/rc.local"
elif [ -w /etc/rc.local ]; then
	RCLOCAL="/etc/rc.local"
fi

# update startup script
if [ ! -z "$RCLOCAL" ]; then
	grep motd-create $RCLOCAL > /dev/null
	if [ "$?" = "1" ]; then
		echo >> $RCLOCAL
		echo "# create/update the /etc/motd file" >> $RCLOCAL
		echo "/usr/local/sbin/motd-create > /dev/null" >> $RCLOCAL
	fi
fi
