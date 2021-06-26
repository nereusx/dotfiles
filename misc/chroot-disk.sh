#!/bin/sh
#
#	typical mount for repairs
#

disk=
mountpoint=/mnt/disk

###

if [ ! -d $mountpoint ]; then
	mkdir -p $mountpoint
fi
if [ -z "$disk" ]; then
	mount ${mountpoint}
else
	mount $disk $mountpoint
fi
mount --bind /dev ${mountpoint}/dev
mount --bind /sys ${mountpoint}/sys
mount --bind /proc ${mountpoint}/proc
chroot ${mountpoint} $*
umount ${mountpoint}/proc
umount ${mountpoint}/sys
umount ${mountpoint}/dev
umount ${mountpoint}

