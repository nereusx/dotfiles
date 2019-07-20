# system wide pulseaudio

System-wide [and/or intranet] Settings

You dont need to rebuild the pulseaudio.

1. Copy etc-pulse/ files to /etc/pulse/
1. Copy etc-profile/ files to /etc/profile.d/
1. Enable system daemon (void-pkg -e pulseaudio)
1. Reboot

Default it is configured to listen only at unix domain socket.

For intranet edit the /etc/pulse/system.pa and enable the
`module_native_protocol_tcp`

Test server 
```
pactl -s unix:/tmp/pulse-server info
```

* If its protocol_tcp is enabled, it should not need to specify the server.

* If you still have problems with unix socket, just enable intranet with localhost only address.

Tested:
* voidlinux - 20/07/2019
* slackware64 current - 20/07/2019
* xubuntu 19.04 - 20/07/2019




