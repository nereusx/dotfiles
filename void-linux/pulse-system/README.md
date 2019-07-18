# system wide pulseaudio

System-wide [and/or intranet] Settings

You dont need to rebuild the pulseaudio.

1. Copy etc-pulse/ files to /etc/pulse/
1. Copy etc-profile/ files to /etc/profile.d/
1. Enable system daemon (void-pkg -e pulseaudio)
1. Reboot

Default it is configured to listen only at localhost and unix domain socket.
See comments at /etc/pulse/daemon.conf


