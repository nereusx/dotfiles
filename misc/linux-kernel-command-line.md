# Parameters for linux kernel

# screen-saver for console
blankconsole=600

# disable IPv6
ipv6.disable=1

# Thinkpad T440 fix touchpad
i8042.reset i8042.nomux i8042.nopnp i8042.noloop

# less messages (good)
quiet

# splash screen (not-good)
splash

# use old standard network device names (eth0,wlan0,etc)
net.ifnames=0 biosdevname=0
