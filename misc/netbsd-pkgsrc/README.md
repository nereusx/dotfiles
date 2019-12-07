# NetBSD packages for Linux

You can use NetBSD ports instead of official distro's repositories, maybe in most cases this is not a good idea,
but you can use it as additional repository when you need it.
As for me, I really like BSD more than Linux, but I prefer Linux kernel for its compatibility with several devices.

https://www.pkgsrc.org/

## The list of the packages by category
	
http://cdn.netbsd.org/pub/pkgsrc/current/pkgsrc/README.html

## Install

First remove BSD make if you have already installed.

Then:

```
bash
./install-pkgsrc
cp etc/profile.d/netbsd-pkgsrc.sh /etc/profile.d/
```

The reboot... (just variables in /etc/profile.d/)

