#!/bin/sh
app=./void
$app -i postfix mailx
mkfifo /var/spool/postfix/public/pickup
$app -e postfix

