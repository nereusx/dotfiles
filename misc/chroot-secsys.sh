#!/bin/sh

mountpoint=/mnt/disk

###

if [ ! -d $mountpoint ]; then
	mkdir -p $mountpoint
fi
mount ${mountpoint}
mount --bind /dev ${mountpoint}/dev
mount --bind /sys ${mountpoint}/sys
mount --bind /proc ${mountpoint}/proc
chroot ${mountpoint} $*
umount ${mountpoint}/proc
umount ${mountpoint}/sys
umount ${mountpoint}/dev
umount ${mountpoint}

