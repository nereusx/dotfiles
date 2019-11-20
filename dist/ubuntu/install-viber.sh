#!/bin/sh
apt install flatpak
[ ! -d ~/.bin ] && mkdir ~/.bin
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak -y update
flatpak -y install com.viber.Viber
cat << EOF > ~/.bin/viber
#!/bin/sh
if [ -x /opt/viber/Viber ]; then
	exec /opt/viber/Viber
else
	exec flatpak run com.viber.Viber
fi
EOF
chmod +x ~/.bin/viber

# ajust scaling
# exec env QT_SCALE_FACTOR=0.5 flatpak run com.viber.Viber

# === without flatpak ===
#
### install openssl-1.0
#
# dpkg -i missing-packages/*
#
### install viber
#
# wget https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb
# dpkg -i viber.deb
#
### run it
#
# /opt/viber/Viber &
#


