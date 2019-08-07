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



