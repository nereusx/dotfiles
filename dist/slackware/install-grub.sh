#!/bin/sh
#
#	Use it on EFI systems.
#
#	You need the EFI partition to be mounted at /boot/efi
#
#	Note: enter in /boot/efi an remove anything
#
if [ -d /boot/efi ]; then
	grub-install
	cp sbin/update-grub /usr/sbin
	/usr/sbin/update-grub
else
	echo "/boot/efi not found!"
fi
