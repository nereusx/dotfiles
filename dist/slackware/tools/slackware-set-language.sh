#!/bin/sh
if [ $# -gt 0 ]; then
	LANG="$1"
else
	LANG=el_GR.UTF-8
fi
sed -i "s/^export LANG=en_US.UTF-8/export LANG=$LANG/" /etc/profile.d/lang.sh
sed -i "s/^setenv LANG en_US.UTF-8/setenv LANG $LANG/" /etc/profile.d/lang.csh
echo "reboot required"
