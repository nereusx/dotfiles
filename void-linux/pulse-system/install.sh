#!/bin/sh
cp etc-profile/* /etc/profile.d/
cp etc-pulse/*   /etc/pulse/
../void-pkg -e pulseaudio
echo "reboot required"
