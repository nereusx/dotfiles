#!/bin/sh
app=./ubuntu-pkg
if [ ! -d /srv/public ]; then
	mkdir /srv/public
	chown -R nobody:nogroup /srv/public
	chmod -R ugo+rswX /srv/public
fi
$app -i smbclient samba smb4k fusesmb smbnetfs
cp etc/samba/* /etc/samba/
$app -e smbd
