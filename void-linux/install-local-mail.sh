#!/bin/sh
app=./void-pkg
$app -i postfix mailx
mkfifo /var/spool/postfix/public/pickup
$app -e postfix

