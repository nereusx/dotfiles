#!/bin/sh
# Default acpi script that takes an entry for all actions

IFS=${IFS}/
set $@

dir="/etc/acpi"
logger "ACPI got: $* ($dir/$1-$2)"
if [ -x "$dir/$1-$2" ]; then
	exec "$dir/$1-$2" $3 $4 $5 $6
	exit
fi
case "$1" in
  button)
    case "$2" in
      power) /sbin/init 0
         ;;
      *) logger "ACPI action $2 is not defined"
         ;;
    esac
    ;;
  *)
    logger "ACPI group $1 / action $2 is not defined"
    ;;
esac
