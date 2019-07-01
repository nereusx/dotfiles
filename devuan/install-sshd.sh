#!/bin/sh
app=./deb-pkg
$app -i ssh sshfs openssh-server filezilla putty
cp etc/ssh/* /etc/ssh/
$app -e ssh
