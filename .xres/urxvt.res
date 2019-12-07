!!	URXVT
!!	http://cvs.schmorp.de/rxvt-unicode/doc/rxvt.7.html

! if there is pro with the font, use the italic bold and bolditalic format
!urxvt.italicFont: -xsg-xsg fixed 167-bold-b-normal--14-140-72-72-c-80-iso10646-1
!urxvt.boldFont: 7x14B
!urxvt.boldItalicFont: -xsg-xsg fixed 167-bold-b-normal--14-140-72-72-c-80-iso10646-1

urxvt.font: \
	xft:XSG Term 209:pixelsize=18,\
	-*-xsg term 189-*-*-*-*-*-*-100-100-p-*-iso10646-1,\
	-xsg-xsg fixed 210-*-*-*-*-21-*-100-100-p-*-iso10646-1,\
	xft:XSG Fixed 189:pixelsize=18,\
	xft:XSG Fixed 188:pixelsize=18,\
	xft:XSG Fixed 178:pixelsize=17,\
	xft:XSG Fixed 167:pixelsize=16,\
	7x14B,7x14, \
	xft:Terminus:bold:pixelsize=15

urxvt.geometry: 160x40

urxvt.reverseVideo: false

! --- --- --- --- --- ---

urxvt.iconFile: /usr/share/icons/urxvt-icon.png
uxterm.metaSendsEscape: true

urxvt.saveLines: 4096
urxvt.iso14755: false
urxvt.iso14755_52: false
urxvt.cursorColor: #00ff00
urxvt.cursorBlink: true
urxvt*skipBuiltinGlyphs: true
urxvt.scrollstyle:      plain
urxvt.secondaryScroll:  true

! full example of xft format, URxvt.font: xft:monaco:bold:size=10
! try it real time
!	$ printf '\e]710;%s\007' "xft:Terminus:pixelsize=12"

urxvt.scrollBar:false
! scroll in relation to buffer (with mouse scroll or Shift+Page Up)
!urxvt.scrollWithBuffer: true
! scroll back to the bottom on keypress
!urxvt.scrollTtyKeypress: true
! URL selection
!urxvt.url-select.launcher: /usr/bin/xdg-open
!urxvt.url-select.underline: true

! blackish with transparency
urxvt.depth: 32
!urxvt.background: rgba:0000/0000/0000/dddd
urxvt.background: rgba:0000/0000/0000/eeee

!!	URXVT Linux Colors

!! default foreground & background colors
urxvt*foreground: #CCCCCC
!urxvt*background: #000000

! black
urxvt*color0:  #000000
urxvt*color8:  #686868
! red
urxvt*color1:  #B21818
urxvt*color9:  #FF5454
! green
urxvt*color2:  #18B218
urxvt*color10: #54FF54
! yellow
urxvt*color3:  #B26818
urxvt*color11: #FFFF54
! blue
!urxvt*color4:  #1818B2
!urxvt*color4:  #1818FF
urxvt*color4:  #18187F
!urxvt*color12: #5454FF
urxvt*color12: #7474FF
! purple
urxvt*color5:  #B218B2
urxvt*color13: #FF54FF
! cyan
urxvt*color6:  #18B2B2
urxvt*color14: #54FFFF
! white
urxvt*color7:  #B2B2B2
urxvt*color15: #FFFFFF

!! urxvt + perl ext

! tabbed: shift+down = newtab, shift+left/right = go to prev/next tab, ctrl+left/right=move tab, ctrl+d = close tab

! with tabs
!urxvt.perl-ext-common: default,matcher,-searchable-scrollback,bell-command,clipboard,tabbed

! without tabs, for use with tmux
!urxvt.perl-ext-common: default,-searchable-scrollback,bell-command,selection-to-clipboard,pasta,matcher,keyboard-select,clipboard

! minimal,tmux
urxvt.perl-ext-common: clipboard

! clipboard
urxvt.clipboard.copycmd: xclip -i -selection clipboard
urxvt.clipboard.pastecmd: xclip -o -selection clipboard
urxvt.keysym.Control-Shift-C: perl:clipboard:copy
urxvt.keysym.Control-Shift-V: perl:clipboard:paste
urxvt.clipboard.autocopy: true

!
URxvt.url-launcher: firefox
URxvt.matcher.button:  1
URxvt.colorUL: #4682B4
URxvt.tabbed.tabbar-fg: 2
URxvt.tabbed.tabbar-bg: 0
URxvt.tabbed.tab-fg: 0
URxvt.tabbed.tab-bg: 2
URxvt.tabbed.autohide:  yes
URxvt.tabbed.new-button: no
URxvt.tabbed.title: yes
URxvt.tabbed.reopen-on-close: yes
!URxvt.keysym.Control-t: perl:tabbed:new_tab
!URxvt.keysym.Control-Tab: perl:tabbed:next_tab
!URxvt.keysym.Control-Shift-Tab: perl:tabbed:prev_tab
!URxvt.keysym.Control-Shift-Left: perl:tabbed:move_tab_left
!URxvt.keysym.Control-Shift-Right: perl:tabbed:move_tab_right
!URxvt.keysym.Control-Shift-R: perl:tabbed:rename_tab

urxvt.bell-command: play -v 0.25 -q /usr/share/sounds/beep.wav

