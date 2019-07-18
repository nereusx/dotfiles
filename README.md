# dotfiles

Slackware64 14.2, VoidLinux, Xubuntu64 18+, FreeBSD and several other distros

These files are for ***personal use***, but **you may need**

* the **.jed/** directory as I have it (BRIEF v3.1 texteditor, with special configurations for desktops, laptops, and several terminal types).

* pulseaudio-system/,  **system-wide pulseaudio** configuration for multiple users in local system, and/or in LAN.

* my tcsh scripts, include **.tcshrc**

* install XFCE system sound theme for void-linux and xubuntu

* several patches for each distro

## The ~/.jed directory
Just copy it to your home directory, and set the JED_HOME environment variable
```
setenv JED_HOME ${HOME}/.jed
```

The `~/.jed/terminal.sl` feel free to change as you like, it is exists only to fix keyboard escape codes in several terminal emulators in serveral distros.

You can get my special jed version [here](https://github.com/nereusx/jed). Then go to jed directory and build it:
```
mkdir /usr/share/jed
ln -s /usr/share/jed /usr/jed
./configure --prefix=/usr
make && make install
```

Note: I discover that in a few distros, jed (and my ~/.jed scripts) are not working well because `shsl` (part of libslang that JED is uses) isn't installed even if libslang it is.

## Help files (~/.help)
Help files are written for 132x35 terminals

## Distro's subdirectories
There many distro's subdirectories that contains fresh install scripts, and several patches that I had to write...

slackware (my previous main distro),
void (main distro) and ubuntu (my backup distro) are the most important.
The other's are just my tests.

I have serveral ROOT partitions (32-64GB) which are distros installed,
one home partition witch is common for all distros and a huge magnetic disk which is my /srv directory.
There are many utilities to keep all those in working order.

## WARNING

* I use BRIEF's text editor keys ***everywhere***, even in tcsh
* with minor exception like joe, where I use WordStar keys
* My shell is the **tcsh**, so .tcshrc is last version, the other shells are follow... Also, install `tcsh` before use anything.

## Notes
1. local-bin could be installed at ~/.bin instead of /usr/local/bin
1. all are free under GPL; a few are not mine
1. Some C-based utilities are in [unix-utils](https://github.com/nereusx/unix-utils) repository
