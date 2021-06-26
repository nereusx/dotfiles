# MOTD subsystem

The `/etc/motd` is a file on Unix-like systems that contains a "message of the day",
used to send a common message to all users in a more efficient manner than sending
them all an e-mail message.
The contents of the file `/etc/motd` are displayed by the Unix login command
after a successful login, and just before it executes the login shell.

## scripts

* `motd-create` rebuilds `/etc/motd`
* `motd-add` appends administrators messages to MOTD, if not parameter passed then clears the queue;
  `motd-create` must used after new message to update MOTD.
* `motd-daily-update` used in cron or `rc.local` to refresh MOTD; admins messages are not cleared.

## files

* `/etc/motd` the final MOTD text file

* `/etc/motd.d/` the scripts directory. The command `motd-create` runs all the executables of this
directory and creates the `/etc/motd` by theirs output.

The default scripts are checking for files to replace their contents.
You can create those files instead of edit scripts:

* `/etc/motd-head` the header
* `/etc/motd-quote` quote to be displayed
* `/etc/motd-queue` list of admin messages
* `/etc/motd-tail` the footer

You can add / edit / replace / remove / disable the scripts at `/etc/motd.d` as you wish.
To disable a script just remove the executable attribute, `chmod -x /etc/motd.d/file`.

## install

```
./install.sh
```

