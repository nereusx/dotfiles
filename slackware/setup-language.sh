#!/bin/sh
LANG=el_GR.UTF-8
sed -i "s/en_US.UTF-8/$LANG/" /etc/profile.d/lang.sh
sed -i "s/en_US.UTF-8/$LANG/" /etc/profile.d/lang.csh
echo "reboot required"
