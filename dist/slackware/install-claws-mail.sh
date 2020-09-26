#!/bin/sh
#
#	claws-mail is a nice GUI mail client (SMTP/POP3/IMAP) that do not
#	use HTML messages. Also, it offers several plugins, stay in tray,
#	bogofilter, spamassasin, etc...
#
#	Note: it requires libsasl2.a, it is not installed by slackware
#
sbo=/usr/sbin/sbopkg
[ -x $sbo ] || ./install-sbopkg

if [ -x $sbo ]; then
	$sbo -B -i libetpan
	$sbo -B -i claws-mail
fi
