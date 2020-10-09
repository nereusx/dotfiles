# xinitrc subsystem

Creates ~/.xinitrc and ~/.xsession by selecting the desktop environment
by using xwmconfig.

The data for each desktop environment are stored in `xde.database`.
It is a plain text file.

## Add or edit a DE

```
edit xde.database
make
```

## Select the default DE

```
xwmconfig
```

