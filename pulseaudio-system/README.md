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

* I suggest to remove RTKIT except you are audio professional:

```
rm /usr/share/dbus-1/system-services/org.freedesktop.RealtimeKit1.service
```

## What is good with system mode for typical desktop use

1. There will be one sound server for the whole system, yeah!

1. All users in pulse-access group could use the sound server.

1. You can use sounds/speech in scripts, notification, warnings, etc.

## What is wrong with system mode?

In most desktop use cases, system mode likely is not the right choice.
There are use cases where system mode does make sense, and these are listed further down.

Note: The developer use the dekstop and means server of something.

Here are a couple of reasons why running PA in system mode can be problematic in desktop use cases.

1. Security: Much like the X server as soon as you are authenticated you have complete control of the sound server,
no further per-object access checks are done. **[GOOD, that is what I want]**

1. Related to the previous point, one especially problematic thing from security point of view is module loading.
Anyone who has access can load and unload modules. Module loading can be disabled, but then bluetooth
and alsa hotplug functionality doesn't work. **[GOOD, that is what I want]**

1. When in system mode, shared memory data transport is disabled for security reasons, which means: much higher memory usage
and CPU load in system mode. **[DONT CARE]**

1. The module-xxx-restore modules maintain state that is inheritely user specific, but when run in system mode
is shared between users. **[DONT CARE]**

1. Security: there are no size limits on state data, which enables users to flood /var unless you employ quotas
on the pulse user. **[pulse-access users or not?]**

1. Security: all users that have access to the server can sniff into each others audio streams,
listen to their mikes, and so on. **[pulse-access users only?]**

1. When in system mode you also lose a lot of further functionality, like the bridging to jack, to rygel (upnp),
to X11, to ckit, and so on And, most importantly: it is explicitly not designed for it, you are on your own if you use it.
The maintainer's interest in making sure system mode is well supported is rather minimal. **[DIDNT NEEDED]**

