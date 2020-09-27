#!/bin/sh

cp sbin/* /usr/sbin/
cp tools/* /usr/sbin/

./install-slackpkg-plus.sh
./install-sbopkg.sh
./install-my-unix-utils.sh
./install-xclip.sh
./install-pick-ndc-version.sh
./install-fzy.sh
