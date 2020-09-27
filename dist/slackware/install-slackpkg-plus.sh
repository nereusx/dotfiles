#!/bin/sh
if [ -f /etc/slackpkgplus.conf ]; then
	echo "slackpkg+ is already installed, aborting"
	exit 1
fi
installpkg packages/slackpkg*
cp etc/slackpkg/* /etc/slackpkg/

slackpkg update gpg
slackpkg update
slackpkg upgrade-all
slackpkg install-new
