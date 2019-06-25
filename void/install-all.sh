#!/bin/sh
xbps-install void-repo-nonfree
for f in *-packages; do
	echo "=== installing $f"
	if [ -d $f ]; then
		cd $f
		for d in *; do
			if [ -d $d ]; then
				cd $d
				./install.sh
				cd ..
			fi
		done
		cd ..
	else
		cat $f | xargs xbps-install -y
	fi
done

# additional services
cd missing-services
for d in *; do
	if [ -d $d ]; then
		cd $d
		./install.sh
		cd ..
	fi
done
cd ..

#
./install-webcam.sh

# wine needs 32bit
xbps-install void-repo-multilib
xbps-install void-repo-multilib-nonfree

./install-wine.csh

# install nvidia driver
lspci | grep -i 'vga.*nvidia' > /dev/null
if [ $? = 0 ]; then
	xbps-install -y nvidia
fi

# user needed
./install-viber.sh

#
cp -r etc /

# add samba public directory
if [ ! -d /srv/public ]; then
	mkdir /srv/public
	chown nobody:nogroup /srv/public
	chmod 6777 /srv/public
fi

#
echo "see post-install for next steps"
