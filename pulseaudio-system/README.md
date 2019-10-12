# system wide pulseaudio

System-wide [and/or intranet] Settings

1. `./install.sh`
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



