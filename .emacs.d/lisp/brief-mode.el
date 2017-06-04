;; brief-mode.el -- Brief 3.1 (TM) keybinding for emacs
;;
;; @Author: SUN, Tong  <suntong@users.sourceforge.net>
;; @Copyright (c) 1999-2001, Tong Sun, all right reserved
;; @Version: $Date: 2003/03/25 17:34:30 $ $Revision: 1.10 $
;; @Keywords: brief emulation
;;
;; This program is dedicated to
;;  Kai GroÅﬂjohann <Kai.Grossjohann@CS.Uni-Dortmund.DE>
;; Without his generous help, my program would never exist.
;;
;; This program is based on the LCD Archive Entry:
;; brief|Alex Rezinsky|alexr@msil.sps.mot.com|
;; Copyright (C) 1994 Alexander Rezinsky <alexr@msil.sps.mot.com>
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  

;; Freely distribute and modification. For personal use only.
;; Illegal to use for commercial purposes or in companies.

;;; COMMENTARY
;;; ----------
;;;
;;; Most  of these commands  are Brief3.1(TM) editor emulation.  Some
;;; of them are  working   in little different  manner  then original
;;; brief commands. And as the development evolve, the document may
;;; not be updated as the code itself.
;;;
;;; Original emacs key binding NOT REDEFINED.
;;;
;;;     Cursor over end of line
;;;     -----------------------
;;; In emacs you can't  place cursor over end  of line.  In brief you
;;; free  to  do that.   If you  wish to work  in   brief style - use
;;; "picture mode".
;;;
;;;     Truncate mode
;;;     -------------
;;; Truncate mode. Brief always truncate your lines on screen if thay
;;; are too long.  After  that in brief you  may work with horisontal
;;; scrolling to edit long lines.  In emacs you can use this style as
;;; well,  and  you can use  "fold  mode". By  default emacs works in
;;; "fold mode" -  long lines are fold  and you  may edit it  without
;;; horisontal scrolling.  If you want  brief behavior by default you
;;; should add follow    line  in your  .emacs  file:
;;; (setq-default truncate-lines t)
;;;
;;;     Search and replace
;;;     ------------------
;;; Default  emacs search style  - incremental  search.  If you  want
;;; brief  search style -  use seacrh  through F5  key. In search and
;;; replace (F5 and F6) you   able to use  up/down  arrows to get  in
;;; minibuffer previous/next search (or replace) string. If you press
;;; Shift-mouse-button you will  get menu of previous contexts  (only
;;; if you work in emacs own X-window).
;;;
;;;     Bookmarks
;;;     ---------
;;; Little  different from brief.  Press Alt-J 1 ... Alt-J 9 to
;;; set bookmark and Alt-1 ... Alt-9 to go to the bookmark,
;;; reason being the usage of "go" is more than "set".
;;;
;;;     Saving environment
;;;     ------------------
;;; By default if you  work with this  package it tries to  save your
;;; editor environment  between  different  emacs session.  It saves:
;;; several  last  search and replace   contexts,  bookmarks and same
;;; internal     parameters.  File     to saving     environment    -
;;; "~/.emacs.save".
;;;
;;;     Work inside XTerm window
;;;    -------------------------
;;; Will cause to several problems... But  if you very like work with
;;; editor inside xterm window, please refer back to
;;;  ftp://archive.cis.ohio-state.edu/pub/emacs-lisp/modes/brief.el.Z
;;; for help
;;;
;;;  INSTALLATION
;;;   -----------
;;;
;;; ;; 1. add load-path
;;; (add-to-list 'load-path "~/local/emacs")
;;; ;; 2. issure load-library
;;; (load-library "brief-mode")
;;;

;;; KNOWN BUGS
;;; ----------
;;;
;;;    During keyboard macro definition Cntrl-G key does not
;;; processed appropriately.

;;; HISTORY
;;; -------
;;; v2.0 1999.08.26 Thu    Tong Sun
;;;   First enhancement release.
;;; v1.0 September 8 1993  Alex Rezinsky
;;;   First release.

;;; THANKS TO
;;; ---------
;;;
;;; LCD Archive Entry:
;;; brief|Alex Rezinsky|alexr@msil.sps.mot.com|
;;; Brief editor emulation|
;;; 07-Feb-1995|1.1|~/modes/brief.el.Z|
;;;
;;; pc-keys.el --
;;; ITIID           : $ITI$ $Header $__Header$
;;; Author          : System Administrator Account
;;; Last Modified On: Tue Dec 13 10:29:32 1994
;;;
;;; Chris McMahan
;;; The insert date & time & file name is originally from his post

;;;
;;; KEYBOARD BINDING
;;; ----------------
;;;
;;; You available to change this part to your own keyboard binding
;;; 
;;; For MacOS, some special bindings, in case a full keyboard is not present:
;;; óß¸-x : Same as keypad minus
;;; óß¸-c : Same as keypad plus
;;; óß¸-v : Same as keypad insert
;;; óß¸-backspace : Same as keypad delete
;;;
;;; In addition the following keys have been added
;;;
;;; M-h : Bound to ff-find-other-file : allows quickly loading headers or corresponding imelemntations

(if (string=  window-system "x")
  (progn

    ;; ====================  SEPARATE X-WINDOW  ==============================
    ;; =======================================================================

    ;; content has been move out, effect globaly now

    ;; =======================================================================
    ;; ====================  END OF SEPARATE X-WINDOW  =======================

  )

  (progn

    ;; ====================  XTERM WINDOW  ===================================
    ;; does not support

  )
)

;;; ############################################################# &kbd ###
;;; mb:  Mouse binding
;;; kb:
(global-set-key [vertical-scroll-bar S-mouse-2] 'mouse-split-window-vertically)
(global-set-key [vertical-line       S-mouse-2] 'mouse-split-window-vertically)
(global-set-key [mode-line         S-mouse-2] 'mouse-split-window-horizontally)


;;; kb:    KEY BINDING
;;; kb:    -----------
;;; kb:
;;; kb: == Bookmark
;;; kb:
;;; kb:  Alt-1...Alt-9  - Goto bookmark
(global-set-key [?\M-1] '(lambda() (interactive nil) (goto-bookmark 1)))
(global-set-key [?\M-2] '(lambda() (interactive nil) (goto-bookmark 2)))
(global-set-key [?\M-3] '(lambda() (interactive nil) (goto-bookmark 3)))
(global-set-key [?\M-4] '(lambda() (interactive nil) (goto-bookmark 4)))
(global-set-key [?\M-5] '(lambda() (interactive nil) (goto-bookmark 5)))
(global-set-key [?\M-6] '(lambda() (interactive nil) (goto-bookmark 6)))
(global-set-key [?\M-7] '(lambda() (interactive nil) (goto-bookmark 7)))
(global-set-key [?\M-8] '(lambda() (interactive nil) (goto-bookmark 8)))
(global-set-key [?\M-9] '(lambda() (interactive nil) (goto-bookmark 9)))
;;; kb:  Alt-j          - Set bookmark
(global-set-key [?\M-j] 'set-book)

(global-set-key [tab] 'brief-tab)

;; reserve C-a & C-e for tty mode
;(global-set-key [?\C-a] 'mark-whole-buffer) ; use C-x h instead

;;; kb:
;;; kb: == Normal key binding
;;; kb:
;;; kb:  Alt-a          - Mark stream region
(global-set-key [?\M-a] 'mark-m)
;;; kb:  Alt-b          - Buffer list
(global-set-key [?\M-b] 'buffer-menu)
;;; kb:  Alt-c          - Mark rectangle region
(global-set-key [?\M-c] 'mark-c)

;;; kb:
(global-unset-key "\C-d")
;;; kb:  Ctrl-d Ctrl-d  - Insert date
(global-set-key "\C-d\C-d" 'insert-date)
;;; kb:  Ctrl-d Ctrl-t  - Insert time
(global-set-key "\C-d\C-t" 'insert-time)
;;; kb:  Ctrl-d Ctrl-w  - Insert whole date & time
(global-set-key "\C-d\C-w" 'insert-date-and-time)
;;; kb:  Ctrl-d Ctrl-f  - Insert file name
(global-set-key "\C-d\C-f" 'insert-current-file-name)
;;; kb:  Ctrl-d Ctrl-l  - lowercase the current word or the marked region
(global-set-key "\C-d\C-l" 'lowercase-region-or-word)
;;; kb:  Ctrl-d Ctrl-u  - uppercase the current word or the marked region
(global-set-key "\C-d\C-u" 'uppercase-region-or-word)
;;; kb:  Ctrl-d Ctrl-i  - Upcase the initial of each word in the region.
(global-set-key "\C-d\C-i" 'initials-uppercase-region-or-word)
(global-set-key [?\C-d tab]  'ispell-complete-word)

;;; kb:
;;; kb:  Alt-d          - delete the whole line
(global-set-key [?\M-d] 'delete-complete-line)
;;; kb:  Alt-g          - Goto line
(global-set-key [?\M-g] 'goto-line)
;;; kb:  Alt-k          - delete to the end of line
;;; (global-set-key [?\M-k] 'kill-line)
(global-set-key [?\M-k] 'delete-rest-of-line)
;;; kb:  Alt-i          - Phy. tab (Brief default: Switch insert/overwrite mode)
(global-set-key [?\M-i] 'overwrite-mode) 	;; reserve M-i for phy. tab
(global-set-key [?\C-\M-i] 'overwrite-mode) 	;; no work?
(global-set-key [M-tab] 'overwrite-mode) 	;; no work?
;;; kb:  Alt-l          - Mark line region
(global-set-key [?\M-l] 'mark-l)
;;; kb:  Alt-m          - Mark stream region
(global-set-key [?\M-m] 'mark-m)
;;(global-set-key [?\M-n] 'bury-buffer)
;;; kb:  Alt-n          - Next buffer
(global-set-key [?\M-n] 'next-buffer)

;;; kb:
;;; kb: == for tty environment. Or notepad that has no standard grey-pad keys
(global-unset-key "\C-q")
;;; kb:
;; find & replace, idea from wordstar
;;; kb:  C-q C-f	- Search
(global-set-key [?\M-s] 'mysearch)	;; the brief default
(global-set-key "\C-q\C-f" 'mysearch)
;;; kb:  C-q C-a	- Replace
(global-set-key [?\M-t] 'myquery-replace)	;; the brief default
(global-set-key "\C-q\C-a" 'myquery-replace)
;;; kb:  C-q C-l	- Repeat last search/replace
(global-set-key "\C-q\C-l" 'myresearch)
(global-set-key "\C-q\C-r" 'myresearch-back)
(global-set-key "\C-q\C-p" 'goto-previous) ;; the standard way is C-u C-SPC

;; cut & paste, idea from M$ Windoze
;;; kb:  C-q C-c	- Copy
(global-set-key "\C-q\C-c" 'grey-plus)
;;; kb:  C-q C-v	- Paste
(global-set-key "\C-q\C-v" 'insert-key)
;;; kb:  C-q C-x	- Cut
(global-set-key "\C-q\C-x" 'grey-minus)

;; Mac Only!
;; copy, cut & paste - make Command-C, V, X equivalent to keypad plus, insert, and minus
(if (eq window-system 'ns)
    (cond
     (t
      (define-key osx-key-mode-map `[(,osxkeys-command-key c)] 'grey-plus)
      (define-key osx-key-mode-map `[(,osxkeys-command-key v)] 'insert-key)
      (define-key osx-key-mode-map `[(,osxkeys-command-key x)] 'grey-minus)
      (define-key osx-key-mode-map `[(,osxkeys-command-key backspace)] 'grey-delete)
      )
     )
  )

;;; kb:
;;; kb: == quoting & formatting
;;; kb:
;;; kb:  Ctrl-b         - Wordwrap paragraph
(global-set-key [?\C-b] 'fill-paragraph)
;;; kb:  Alt-q          - Quoted insert
(global-set-key [?\M-q] 'quoted-insert)	;insert key as-is
(global-unset-key "\M-[")
(global-set-key "\M-[\M-]" 'quote-region)
(global-set-key "\M-[\M-[" 'quote-region2)
;;; kb:  Ctrl-q Ctrl-b  - Reformat the quoted paragraph
(global-set-key "\C-q\C-b" 'quote-reformat)
(global-set-key (kbd "M-C-^") 'unfill-paragraph)
(global-set-key [?\C-\M-,] 'unfill-paragraph)

(global-set-key (kbd "M-C-{") 'brief-join{-with-previous-line)

;;; kb:
;;; kb:  Alt-e          - Load file
(global-set-key [?\M-e] 'find-file)
;;; kb:  Alt-f          - Print full name of current file
(global-set-key [?\M-f] '(lambda() (interactive nil) (message (buffer-file-name nil))))
;;; kb:  Alt-r          - Insert file
(global-set-key [?\M-r] 'insert-file)
;;; kb:  Alt-w          - Write current buffer to other file.
(global-set-key [?\M-w] 'save-buffer)
;;; kb:  Ctrl-minus     - Delete curr. buffer
(global-set-key [?\C--] 'kill-this-buffer)
;;; kb:  Alt-minus      - Previous buffer
(global-set-key [?\M--] 'previous-buffer)
;;; kb:
(global-set-key [?\M-h] 'ff-find-other-file)


;;; kb:
;;; kb:  Alt-s          - Emacs default: Center line
;(global-set-key [?\M-s] 'save-buffer)	;; the brief default
;(global-set-key [?\M-s] 'center-line)	;; reset to emacs default
;;; kb:  Ctrl-s		- Emacs default: i-search
;(global-set-key [?\C-s] 'save-buffer) ;; use C-x C-s
				       ;; reserve it for emacs i-search!
;;; kb:
;;; kb:  Ctrl-t		- Delete next word
(global-set-key [?\C-t] 'kill-word)
(global-set-key [?\C-t] 'kill-word-or-whitespace)
;;; kb:  Alt-t          - Toggle truncate mode (see descripton above)
;; (global-set-key [?\M-t] 'invert-truncation)

;;; kb:  Alt-u          - Unmark region
(global-set-key [?\M-u] 'mark-release)
;;; kb:  Alt-x          - Emacs default. 
;; brief default: Exit from emacs. 
(global-set-key [?\M-x] 'save-buffers-kill-emacs)

;; Alt-Meta key binding
(global-set-key [?\A-\M-e]    'find-file-other-frame)
(global-set-key [?\A-\M-x]    '(lambda() (interactive nil) (save-some-buffers t) (kill-emacs)))
(global-set-key [?\A-\M-s]    'desktop-save)

;;; kb:
;;; kb: == FUNCTION KEY BINDING
;;; kb:
;;; kb:  F1		- Jump to other window
(global-set-key [f1]	'other-window)
;(global-set-key [M-f1]	'(lambda() (interactive nil) (raise-frame (next-frame))))
;;; kb:  Alt-F1		- show help for the function at the cursor
(global-set-key [M-f1]	'(lambda() (interactive) (manual-entry (current-word))))

;;; kb:  F2 \/          - Enlarge window vertically
(global-set-key [f2 down]    'enlarge-window)

;; Prepare a prefix map for f3
(define-prefix-command 'split-window-map)
(global-set-key [f3] 'split-window-map)

;;; kb:  F3 \/          - Split window vertically
(define-key split-window-map [down] 'split-window-vertically)
;;;(global-set-key [f3 down]    'split-window-vertically)

;;; kb:  F3 ->          - Split window horizontally
(define-key split-window-map [right] 'split-window-horizontally)
;;;(global-set-key [f3 right]   'split-window-horizontally)


;;; kb:  F2 /\          - Shrink window vertically
(global-set-key [f2 up]      'shrink-window)
;;; kb:  F2 ->          - Enlarge window horizontally
(global-set-key [f2 left]    'shrink-window-horizontally)
;;; kb:  F2 <-          - Shrink window horizontally
(global-set-key [f2 right]   'enlarge-window-horizontally)

;;; kb:  F4             - Delete all other windows
(global-set-key [f4]         'delete-other-windows)
;;; kb:  Alt-F4         - Delete current window
(global-set-key [M-f4]       'delete-window)
(global-set-key [A-M-f4]     'delete-frame)

;;; kb:  F5             - Search
(global-set-key [f5]         'mysearch)
;;; kb:  Shift-F5       - Repeat last search
(global-set-key [S-f5]       'myresearch)
(global-set-key [M-f5]       'mysearch-back)
(global-set-key [escape f5]  'mysearch-back)
(global-set-key [M-S-f5]     'myresearch-back)
;;; kb:  F6             - Replace
(global-set-key [f6]         'myquery-replace)
;;; kb:  Shift-F6       - Repeat last replace
(global-set-key [S-f6]       'myrequery-replace)

;;; kb:  Cntrl-F5       - Toggle case sensitive/unsensitive search
(global-set-key [C-f5]       'case-sensitive-search-toggle)
;;; kb:  Cntrl-F6       - Toggle regular expression search
(global-set-key [C-f6]       'regexp-search-toggle)

;;; kb:  F7             - Begin/end keyboard macro definition
(global-set-key [f7]         'define-keystroke-macro)
;;; kb:  Alt-F7         - Read keyboard macro from external file
(global-set-key [M-f7]       'read-keystroke-macro)
(global-set-key [esc f7]     'read-keystroke-macro)
(global-set-key [escape f7]  'read-keystroke-macro)
;;; kb:  F8             - Execut keyboard macro
(global-set-key [f8]         'execut-keystroke-macro)
;;; kb:  Alt-F8         - Save keyboard macro to external file
(global-set-key [M-f8]       'save-keystroke-macro)
(global-set-key [esc f8]     'save-keystroke-macro)
(global-set-key [escape f8]  'save-keystroke-macro)

;;; kb:  Shift-F7       - Shift stream region left
(global-set-key [S-f7]       'line-shift-left)
;;; kb:  Shift-F8       - Shift stream region right
(global-set-key [S-f8]       'line-shift-right)

;;; kb:  F9             - load macro file
(global-set-key [f9]         'load-file)
;;; kb:  Alt-F9         - load macro library
(global-set-key [M-f9]       'load-library)
(global-unset-key [f10])
;;; kb:  F10 m          - Activate emacs menu
(global-set-key [f10 ?m]      'tmm-menubar)
;;; kb:  F10 F10        - Execute emacs command
(global-set-key [f10 f10]    'execute-extended-command)

(global-set-key [f11]        'mark-c)                      ; F11 or Stop
(global-set-key [f12]        'repeat-complex-command)      ; F12 or Again
(global-set-key [f13]        'mark-m)                      ; Props
(global-set-key [f14]        'undo)                        ; Undo
(global-set-key [kp-multiply] 'undo)                        ; Undo
(global-set-key [f24]        'kill-buffer)                 ; R4
(global-set-key [help help]  'help-for-help)               ; Help Help
(global-set-key [help]       'help-command)                ; Help

;;; kb:
;;; kb: == Cursor key binding
;;; kb:
;;; kb:  Cntrl ->       - Next word
;;; kb:  Cntrl <-       - Previous word
;;; kb:  Cntrl /\       - Vertical scroll up
(global-set-key [C-up] 'pc-keys-scroll-down-one-line)
;;; kb:  Cntrl \/       - Vertical scroll down
(global-set-key [C-down] 'pc-keys-scroll-up-one-line)
;;; kb:  Shift /\	- Previous line
(global-set-key [S-up] 'pc-keys-previous-line)
;;; kb:  Shift \/       - Next line
(global-set-key [S-down] 'pc-keys-next-line)
;;; kb:  Alt /\         - Previous paragraph
(global-set-key [M-up] 'backward-paragraph)
;;; kb:  Alt \/         - Next paragraph
(global-set-key [M-down] 'forward-paragraph)
;;; kb:  Cntrl Shift /\	- scroll-other-window-one-line-down
(global-set-key [C-S-up] 'pc-keys-scroll-other-window-one-line-down)
;;; kb:  Cntrl Shift \/	- scroll-other-window-one-line-up
(global-set-key [C-S-down] 'pc-keys-scroll-other-window-one-line-up)

;;; kb:
;;; kb:  Home           - Begin of current line
;;; kb:  Home Home      - Begin of current window
;;; kb:  Home Home Home - Begin of current buffer
;;; kb:  End            - End of current line
;;; kb:  End End        - End of current window
;;; kb:  End End End    - End of current file
(if (eq window-system 'ns)
  (define-key osx-key-mode-map [end]   'goend)                     ; Home
  (global-set-key [end]   'goend)                     ; Home
)
(if (eq window-system 'ns)
  (define-key osx-key-mode-map [home]   'gohome)                     ; Home
  (global-set-key [home]   'gohome)                     ; Home
)

;;; kb:  Cntrl Home     - Begin of current window
(global-set-key [C-home] 'beginning-of-window)
;;; kb:  Cntrl End      - End of current window
(global-set-key [C-end] 'end-of-window)

(global-set-key [f35]           'pgdn)                     ; PgDn
(global-set-key [f29]           'pgup)                     ; PgUp
;;; kb:  Cntrl PgUp     - Begin of current buffer
(global-set-key [C-prior] 'beginning-of-buffer)
;;; kb:  Cntrl PgDn     - End of current file
(global-set-key [C-next] 'end-of-buffer)
;;; kb:  [C-S-PgUp]     - scroll-other-window-down
(global-set-key [C-S-prior] 'pc-keys-scroll-other-window-down)
;;; kb:  [C-S-PgDn]      - scroll-other-window-up
(global-set-key [C-S-next] 'pc-keys-scroll-other-window-up)


;;; kb:
;;; kb: == Keypad binding
;;; kb:
(global-set-key [insert]        'insert-key)               ; reserve for insert toggle, use S-insert instead
(global-set-key [f18]           'insert-key)               ;  Sun's Paste key
(global-set-key [S-kp-0]	'insert-key)               ; linux name
;;; kb:  Shift-Ins      - Paste region (line/stream/rectangle) from yanc-buffer
(global-set-key [S-insert]      'insert-key)               ; Ins
;;; kb:  Alt-Ins	- Paste region (line/stream/rectangle) from register
(global-set-key [M-insert]      'insert-register)          ; Alt Ins

;;; kb:  Grey +    - Copy region (line/stream/rectangle) to yanc-buffer
(global-set-key [kp-add]        'grey-plus)                ; Grey +
(global-set-key [f16]           'grey-plus)                ;   and Copy
;;; kb:  Alt-Grey+ - Copy region (line/stream/rectangle) to register
(global-set-key [M-kp-add]      'grey-plus-to-reg)         ; Alt Grey +

;;; kb:  Grey -    - Cut region (line/stream/rectangle) to yanc-buffer
(global-set-key [kp-decimal]    'delete-char)              ; Del
(global-set-key [kp-subtract]   'grey-minus)               ; Grey -
(global-set-key [f24]           'grey-minus)               ;   on solaris kbd
(global-set-key [f20]           'grey-minus)               ;   and Cut
;;; kb:  Alt-Grey- - Cut region (line/stream/rectangle) to register
(global-set-key [M-kp-subtract] 'grey-minus-to-reg)        ; Alt Grey -

;;; kb:
;;; kb:  Del            - Delete current character.
;; old one (global-set-key [delete]        'delete-char)              ; Delete
(if (eq window-system 'ns)
  (define-key osx-key-mode-map [kp-delete]  'grey-delete)                     ; Home
 (global-set-key [delete]        'grey-delete)              ; Delete
)
(global-set-key [\d]           'delete-char)              ; Delete
(global-set-key [M-delete]      'backward-kill-word-or-whitespace)
(global-set-key [M-\d]		'backward-kill-word-or-whitespace)
(global-set-key [backspace]     'delete-backward-char)     ; BackSpace
(global-set-key [M-backspace] 	'backward-kill-word-or-whitespace)     ; M-BackSpace


;;; ########################################################### &initv ###
;======== INITIALIZATION OF VARIABLES ================================
;=====================================================================

;; CUSTOMIZABLE VARIABLES
(defvar replace-history-list-save 10)
(defvar search-history-list-save  10)
(defvar search-replace-verbose    nil)
(defvar search-regexp-enabled     nil)
(defvar x-show-stack-reverse      nil)
(defvar window-hscroll-step       10)

(defvar save-environment-filename "~/.emacs.var.brief_s")
;; please refer to tinychist.el in the "tiny" package from Jari Aalto
;; for history files that support simultaneous emacs sessions

;;;
;;; CODE, NOTHING TO CUSTOMIZE BELOW HERE
;;; -------------------------------------
;;;

;; HOOKS
(add-hook 'kill-emacs-hook 'save-emacs-environment)

;; ADDITIONS TO EXISTING KEY MAPS
(define-key  minibuffer-local-completion-map [up]   'previous-history-element)
(define-key  minibuffer-local-completion-map [down] 'next-history-element)
(define-key  minibuffer-local-map [up]		    'previous-history-element)
(define-key  minibuffer-local-map [down]	    'next-history-element)
(define-key  minibuffer-local-ns-map [up]	    'previous-history-element)
(define-key  minibuffer-local-ns-map [down]	    'next-history-element)
(define-key  minibuffer-local-isearch-map [up]	    'previous-history-element)
(define-key  minibuffer-local-isearch-map [down]    'next-history-element)
(define-key  minibuffer-local-must-match-map [up]   'previous-history-element)
(define-key  minibuffer-local-must-match-map [down] 'next-history-element)
(define-key  read-expression-map [up]		    'previous-history-element)
(define-key  read-expression-map [down]		    'next-history-element)



;; NEW KEY MAP FOR SEARCH COMMAND
(defvar repeat-search-command-map (copy-alist minibuffer-local-map))
(define-key repeat-search-command-map  [down]      'next-stack)
(define-key repeat-search-command-map  [up]        'previous-stack)
(define-key repeat-search-command-map  [S-mouse-1] 'x-show-stack)
(define-key repeat-search-command-map  [S-mouse-2] 'x-show-stack)
(define-key repeat-search-command-map  [S-mouse-3] 'x-show-stack)

;; WORK VARIABLES
(setq keyb-buffer-status        nil)
(setq keyb-macro-defined        nil)
(setq last-last-command         nil)
(setq mark-list                 nil)
(setq mark-max-count            10)
(setq reg-flag                  nil)
(setq reg-in-scrap-flag         nil)
(setq reg-point                 nil)
(setq replace-from-history-list nil)
(setq replace-to-history-list   nil)
(setq search-history-list       nil)

;; The following line turns on full path in titlebar
(setq frame-title-format "%S: %f")

;; Overwrite marked bloc
(delete-selection-mode 1)

;; show column number of the cusor
(column-number-mode 1)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)


;;; ########################################################### &initf ###
;======== INITIALIZATION OF MY FUNCTIONS =============================
;=====================================================================


;;; ------------------------------------------------------------- &msf ---
;                                            MISCELANEOUS SIMPLE FUNCTIONS
(defun dummy-function ()
  "Dummy function. Do nothing."
  (interactive nil)
)


(defun check-in-window ()
  "Check if current point in window, and perform horisontal scrolling else."
  (interactive nil)
  (condition-case info
    (if truncate-lines
      (cond
       ((< (current-column) (window-hscroll))
        (scroll-right (- (window-hscroll) (current-column)))
       )
       ((> (+ (current-column) 2) (+ (window-hscroll) (window-width)))
        (scroll-left (+ (- (current-column) (+ (window-hscroll) (window-width))) 3))
       )
      )
    )
    (error
     (ding)
     (remove-hook 'post-command-hook 'check-in-window)
     (message "check-in-window error: %s" info)
    )
  )
)
(add-hook 'post-command-hook 'check-in-window)

(defun invert-truncation ()
  "Invert truncation-lines variable."
  (interactive nil)
  (cond
    ((eq truncate-lines t)
      (setq truncate-lines nil)
      (message "Truncate lines mode is now OFF.")
    )
    (t
      (setq truncate-lines t)
      (message "Truncate lines mode is now ON.")
    )
  )
  (redraw-display)
)


;;; ------------------------------------------------------------- &uso ---
;                                                    USER STACK OPERATIONS
;
; Usage of this functions (previous-stack/next-stack/x-show-stack) :
;
;(define-key <something>-command-map [up]              'previous-stack)
;(define-key <something>-command-map [down]            'next-stack)
;(define-key <something>-command-map <any_mouse_event> 'x-show-stack)
;
; ......
;    (setq stack-number 0)
;    (setq your-current-stack (cons "" <list_which_represent_your_stack>))
;    (setq <something> (read-from-minibuffer
;                        "<Your_prompt>"
;                        ""
;                        <something>-command-map
;                      )
(defun previous-stack ()
  "Insert next element of your stack into the minibuffer"
  (interactive nil)
  (let ((cur-str (nth (1+ stack-number) your-current-stack)))
    (if cur-str
      (progn
        (setq stack-number (1+ stack-number))
	; Erase buffer does not work because the mini-buffer also contains
	; the read-only prompt, so we locate the next prop change
	; and delete from there.
        ;(erase-buffer)
	(setq read-write-start (next-property-change 1))
	(if read-write-start
	    (delete-region read-write-start (point-max))
	  )
        (insert cur-str)
        (goto-char (point-min))
      )
      (error "No preceeding item in your stack")
    )
  )
)

(defun next-stack ()
  "Insert previous element of your stack into the minibuffer"
  (interactive nil)
  (let ((cur-str (nth (1- stack-number) your-current-stack)))
    (if (and cur-str (> stack-number 0))
      (progn
        (setq stack-number (1- stack-number))
	; Erase buffer does not work because the mini-buffer also contains
	; the read-only prompt
        ;(erase-buffer)
	(setq read-write-start (next-property-change 1))
	(if read-write-start
	    (delete-region read-write-start (point-max))
	  )
        (insert cur-str)
        (goto-char (point-min))
      )
      (error "No following item in your stack")
    )
  )
)

(defun x-show-stack (click)
  "Select item in user stack by x-menu"
  (interactive "e")
  (if (string= window-system "x")
    (let ((pos click) (x-user-menu-ex nil) (x-user-menu-ed nil)
          (response nil) (i 0)
         )
      (if x-show-stack-reverse
        (setq i (1- (length your-current-stack)))
        (setq i 1)
      )
      (while (if x-show-stack-reverse
               (> i 0)
               (< i (length your-current-stack))
             )
        (setq x-user-menu-ex (append x-user-menu-ex
                                     (list (cons (nth i your-current-stack)
                                                 (concat "X" (int-to-string i))
                                           )
                                     )
                             )
        )
        (setq x-user-menu-ed (append x-user-menu-ed
                                     (list (cons (nth i your-current-stack)
                                                 (concat "E" (int-to-string i))
                                           )
                                     )
                             )
        )
        (if x-show-stack-reverse
          (setq i (1- i))
          (setq i (1+ i))
        )
      )
      (setq x-user-menu (list "User selection"
                              (cons "Execute immediately" x-user-menu-ex)
                              (cons " Get to minibuffer " x-user-menu-ed)
                        )
      )
      (setq response (x-popup-menu pos x-user-menu))
      (if response
        (progn
          (setq stack-number (string-to-int (substring response 1)))
          (erase-buffer)
          (insert (nth stack-number your-current-stack))
          (cond
            ((string= (substring response 0 1) "E")
             (goto-char (point-min))
            )
            ((string= (substring response 0 1) "X")
             (exit-minibuffer)
            )
            (t
             (message (format
                       "Error in x-user-menu building. Cannot be \"%s\"."
                       response
                      )
             )
            )
          )
        )
      )
    )
  )
)


;;; ------------------------------------------------------------- &stb ---
;                                                SAVING/TRUNCATING BUFFERS
(defun save-user-stack (user-stack user-stack-name user-stack-save-deep)
  (if (<= (length user-stack) user-stack-save-deep)
    (insert (format "(setq %s '%s)\n" user-stack-name
                    (prin1-to-string user-stack)))
    (let ((i 0)(user-stack-temp nil))
      (while (< i user-stack-save-deep)
        (setq user-stack-temp (cons (nth i user-stack) user-stack-temp))
        (setq i (1+ i))
      )
      (insert (format "(setq %s '%s)\n" user-stack-name
                      (prin1-to-string (reverse user-stack-temp))))
    )
  )
)

(defun save-emacs-environment ()
  "Saving of all emacs environment to to file."
  (save-excursion
    (set-buffer (get-buffer-create "*emacs-environment*"))
    (let ((p1 (point)))

      ; Saving of search context
      (save-user-stack search-history-list
                       "search-history-list" search-history-list-save)

      ; Saving of replace context
      (save-user-stack replace-from-history-list
                       "replace-from-history-list" replace-history-list-save)
      (save-user-stack replace-to-history-list
                       "replace-to-history-list" replace-history-list-save)

      ; Saving of RegEx search state
      (insert (format "(setq search-regexp-enabled %s)\n" (prin1-to-string search-regexp-enabled))) 


      ; Saving of bookmark list
      (if mark-list
        (let ((i 0)(el nil))
          (insert "(setq mark-list\n  (list\n")
          (while (< i mark-max-count)
            (setq el (assoc i mark-list))
            (if el
              (insert (format "    %s\n" (prin1-to-string
                                           (list 'list
                                           (car el)
                                           (car (cdr el))
                                           (car (cdr (cdr el)))
                                           (car (cdr (cdr (cdr el))))
                                           nil))))
            )
            (setq i (1+ i))
          )
          (insert "  )\n)\n")
        )
        (insert "(setq mark-list nil)\n")
      )
      (insert (format "(setq register-alist '%s)\n"
                      (prin1-to-string register-alist)))
;;;      (insert (format "(setq kill-ring '%s)\n"
;;;                      (prin1-to-string kill-ring)))
;;;      (insert (format "(setq killed-rectangle '%s)\n"
;;;                      (prin1-to-string killed-rectangle)))
;;;      (insert (format "(setq kill-ring-yank-pointer '%s)\n"
;;;                      (prin1-to-string kill-ring-yank-pointer)))
;;;      (insert (format "(setq reg-in-scrap-flag '%s)\n" reg-in-scrap-flag))
      (write-region p1 (point) save-environment-filename)
    )
    (kill-buffer "*emacs-environment*")
  )
)


;;; ------------------------------------------------------------- &lns ---
;                                                                LINES ...
(defun beg-line-reg-point (pnt)
  (save-excursion
    (goto-char pnt)
    (beginning-of-line)
    (point)
  )
)

(defun end-line-reg-point (pnt)
  (save-excursion
    (goto-char pnt)
    (beginning-of-line)
    (next-line 1)
    (beginning-of-line)
    (point)
  )
)

(defun delete-line ()
  "Delete current line."
  (interactive nil)
  (kill-region (beg-line-reg-point (point)) (end-line-reg-point (point)))
  (message "Simple line cut to scrap")
)

(defun delete-complete-line ()
  ""
  (interactive)
  (beginning-of-line)
  (setq begin-point (point))
  (forward-line 1)
  (setq end-point (point))
  (delete-region begin-point end-point))

(defun delete-rest-of-line ()
  ""
  (interactive nil)
  (setq begin-point (point))
  (end-of-line)
  (setq end-point (point))
  (delete-region begin-point end-point))

(defun cut-lines (start end)
  "Cut lines region."
  (interactive nil)
  (kill-region (beg-line-reg-point start) (end-line-reg-point end))
)

(defun copy-lines (start end)
  "Copy lines region."
  (interactive nil)
  (copy-region-as-kill (beg-line-reg-point start) (end-line-reg-point end))
)

(defun copy-line ()
  "Copy current line in yanc-buffer."
  (interactive nil)
  (copy-region-as-kill (beg-line-reg-point (point))
                       (end-line-reg-point (point)))
  (message "Simple line copied to scrap")
)

;;; ------------------------------------------------------------- &lsh ---
;                                                            Line shifting
; Credit: Kai

;
; to use the line shifting functions, use M-a to mark region first.
;

(defun line-shift-right (b e)
  "Shift stream region left."
  (interactive "r")
  (indent-rigidly b e 1))

(defun line-shift-left (b e)
  "Shift stream region right."
  (interactive "r")
  (indent-rigidly b e -1))





;;; ------------------------------------------------------------- &hne ---
;                                                                 HOME/END
(defun gohome ()
  "Go to beginning of line/window/buffer.
  First hitting key goes to beginning of line, second in a row goes to
  beginning of window, third in a row goes to beginning of buffer."
  (interactive)
  (let* ((keys (recent-keys))
	 (len (length keys))
	 (key1 (if (> len 0) (elt keys (- len 1)) nil))
	 (key2 (if (> len 1) (elt keys (- len 2)) nil))
	 (key3 (if (> len 2) (elt keys (- len 3)) nil))
	 (key-equal-1 (eq key1 key2))
	 (key-equal-2 (and key-equal-1 (eq key2 key3))))
    (cond (key-equal-2 (if mark-active
			   (goto-char (point-min))
			 (beginning-of-buffer)))
	  (key-equal-1 (if mark-active () (push-mark))
		       (move-to-window-line 0))
	  (t (beginning-of-line)))))

(defun goend ()
  "Go to end of line/window/buffer.
  First hitting key goes to end of line, second in a row goes to end
  of window, third in a row goes to end of buffer."
  (interactive)
  (let* ((keys (recent-keys))
	 (len (length keys))
	 (key1 (if (> len 0) (elt keys (- len 1)) nil))
	 (key2 (if (> len 1) (elt keys (- len 2)) nil))
	 (key3 (if (> len 2) (elt keys (- len 3)) nil))
	 (key-equal-1 (eq key1 key2))
	 (key-equal-2 (and key-equal-1 (eq key2 key3))))
    (cond (key-equal-2 (if mark-active
			   (goto-char (point-max))
			 (end-of-buffer)))
	  (key-equal-1 (if mark-active () (push-mark))
		       (move-to-window-line -1)
		       (end-of-line))
	  (t (end-of-line)))))



;;; ------------------------------------------------------------- &snp ---
;                                                       SCROLLING & PAGING
(defun pgdn (&optional ignore)
  "Page down."
  (interactive nil)
  (let ((wc (current-column))
        (wl (1- (count-lines (window-start) (point))))
       )
    (if (eq wc 0)
        (setq wl (1+ wl))
    )
    (setq rpt current-prefix-arg)
    (if (not rpt)
      (setq rpt 1)
    )
    (while (> rpt 0)
       (scroll-up (- (window-height) 2))
       (setq rpt (1- rpt))
    )
    (move-to-window-line wl)
  )
)

(defun pgup (&optional ignore)
  "Page up."
  (interactive nil)
  (let ((wc (current-column))
        (wl (1- (count-lines (window-start) (point))))
       )
    (if (eq wc 0)
        (setq wl (1+ wl))
    )
    (setq rpt current-prefix-arg)
    (if (not rpt)
      (setq rpt 1)
    )
    (while (> rpt 0)
       (scroll-down (- (window-height) 2))
       (setq rpt (1- rpt))
    )
    (move-to-window-line wl)
  )
)

;The following function will go to the beginning of the window:

(defun beginning-of-window ()
  (interactive)
  (move-to-window-line 0))

;The following function will go to the end of the window:

(defun end-of-window ()
  (interactive)
  (move-to-window-line -1)
  (end-of-line))

;;; ------------------------------------------------------------- &bkm ---
;                                                                BOOKMARKS
(defun set-book ()
  "Set bookmark"
  (interactive nil)
  (message "Set Bookmark #")
  (set-bookmark (- (read-char) ?0))
)

(defun set-bookmark (mrk)
  "Set bookmark routine."
  (interactive nil)
  (setq wc (current-column) wl (count-lines 1 (point)))
    (if (eq wc 0)
	(setq wl (1+ wl))
    )
  (setq found-element (assoc mrk mark-list))
  (cond
    ((and (not (null found-element))
          (car (cdr (cdr (cdr (cdr found-element)))))
     )
      (cond
        ((y-or-n-p (format "Bookmark #%d exist (buffer:\"%s\" L:%d C:%d). Overwrite it ? "
			   (car found-element)
			   (car (cdr (cdr (cdr found-element))))
			   (car (cdr found-element))
			   (1+ (car (cdr (cdr found-element))))
		    )
         )
	  (setq found-element (list mrk wl wc (buffer-name) t))
	  (setq mark-list (cons found-element mark-list))
	  (message "Bookmark #%d dropped in buffer \"%s\" L:%d C:%d."
		   (car found-element)
		   (car (cdr (cdr (cdr found-element))))
		   (car (cdr found-element))
		   (1+ (car (cdr (cdr found-element))))
          )
        )
        (t
	  (message "Bookmark #%d not overwrited" (car found-element))
        )
      )
     )
     (t
       (setq mark-list (cons (list mrk wl wc (buffer-name) t) mark-list))
       (message "Bookmark #%d dropped in buffer \"%s\" L:%d C:%d."
		 mrk (buffer-name) wl (1+ wc))
     )
  )
)

(defun goto-book ()
  "Goto bookmark"
  (interactive nil)
  (message "Goto Bookmark #")
  (goto-bookmark (- (read-char) ?0))
)

(defun goto-bookmark (mrk)
  "Goto bookmark"
  (interactive nil)
  (setq found-element (assoc mrk mark-list))
  (cond
    ((null found-element)
      (message "Bookmark number #%d not exist !!!" mrk)
    )
    (t
      (switch-to-buffer (car (cdr (cdr (cdr found-element)))))
      (set-buffer (car (cdr (cdr (cdr found-element)))))
      (goto-line (car (cdr found-element)))
      (move-to-column (car (cdr (cdr found-element))))
    )
  )
)

(defun goto-previous (arg)
"Goto previous position."
  (interactive "*p")
  (set-mark-command (- arg)))


;;; ------------------------------------------------------------- &snr ---
;                                                         SEARCH & REPLACE
(defun mysearch (&optional arg)
  "Search forward"
  (interactive nil)
  (if arg
    (setq src-str arg)
    (setq stack-number 0)
    (setq your-current-stack (cons "" search-history-list))
    (setq src-str (read-from-minibuffer
                   "String to search : "
                   ""
                   repeat-search-command-map
                  )
    )
    (setq search-history-list (cons src-str search-history-list))
  )
  (if (if search-regexp-enabled
        (re-search-forward src-str (point-max) t 1)
        (search-forward src-str (point-max) t 1)
      )
    (progn
      (if search-replace-verbose
        (message "<%s> found in line = %d & column = %d"
                 src-str
                 (if (bolp)
                   (1+ (count-lines 1 (point)))
                   (count-lines 1 (point))
                 )
                 (1+ (- (current-column) (length src-str)))
        )
        (message "<%s> found." src-str)
      )
      (goto-char (match-beginning 0))
      t
    )
    (message "<%s> not found." src-str)
    nil
  )
)

(defun mysearch-back (&optional arg)
  "Search backward"
  (interactive nil)
  (if arg
    (setq src-str arg)
    (setq stack-number 0)
    (setq your-current-stack (cons "" search-history-list))
    (setq src-str (read-from-minibuffer
                   "String to backsearch : "
                   ""
                   repeat-search-command-map
                  )
    )
    (setq search-history-list (cons src-str search-history-list))
  )
  (if (if search-regexp-enabled
        (re-search-backward src-str 0 t 1)
        (search-backward src-str 0 t 1)
      )
    (progn
      (if search-replace-verbose
        (message "<%s> found in line = %d & column = %d"
                 src-str
                 (if (bolp)
                   (1+ (count-lines 1 (point)))
                   (count-lines 1 (point))
                 )
                 (1+ (current-column) )
        )
        (message "<%s> found." src-str)
      )
      t
    )
    (message "<%s> not found." src-str)
    nil
  )
)

(defun myresearch ()
  "Research forward"
  (interactive nil)
  (cond ((eq (car search-history-list) nil)
	 (message "Nothing to research")
        )
	(t (goto-char (1+ (point)))
	   (if (eq (mysearch (car search-history-list)) nil)
	     (goto-char (1- (point)))
           )
        )
  )
)

(defun myresearch-back ()
  "Research backward"
  (interactive nil)
  (cond ((eq (car search-history-list) nil)
	 (message "Nothing to research")
        )
	(t (mysearch-back (car search-history-list))
        )
  )
)

(defun myquery-replace ()
  "My query replace."
  (interactive nil)

  (setq stack-number 0)
  (setq your-current-stack (cons "" replace-from-history-list))
  (setq from-string (read-from-minibuffer
                     "Query replace: "
                     ""
                     repeat-search-command-map
                    )
  )
  (setq replace-from-history-list (cons from-string replace-from-history-list))

  (setq your-current-stack (cons "" replace-to-history-list))
  (setq to-string (read-from-minibuffer
                   (concat "Query replace <" from-string "> with : ")
                   (nth stack-number your-current-stack)
                   repeat-search-command-map
                  )
  )
  (setq replace-to-history-list (cons to-string replace-to-history-list))

  (perform-replace from-string to-string t search-regexp-enabled nil)
  (message "Done")
)

(defun myrequery-replace ()
  "My re- query replace."
  (interactive nil)
  (cond
    ((or (null replace-from-history-list) (null replace-to-history-list))
      (message "Nothing to re-replace")
    )
    (t
      (perform-replace (car replace-from-history-list)
                       (car replace-to-history-list) t search-regexp-enabled nil)
      (message "Done")
    )
  )
)

(defun case-sensitive-search-toggle ()
  "Toggle case sensitivity of search."
  (interactive nil)
  (if (setq case-fold-search (not case-fold-search))
      (message "Case unsensitive search.")
    (message "Case sensitive search.")
  )
)

(defun regexp-search-toggle ()
  "Regular expression search toggle."
  (interactive nil)
  (if (setq search-regexp-enabled (not search-regexp-enabled))
      (message "Regular expression search/replace enabled.")
    (message "Regular expression search/replace disabled.")
  )
)


;;; ------------------------------------------------------------- &cnp ---
;                                                   CUT/COPY/PASTE REGIONS
(defun mark-c ()
  "Mark rectangle region."
  (interactive nil)
  (mark-common 'c)
  (message "Left upper corner of column (rectangle) region marked")
)

(defun mark-l ()
  "Mark line region."
  (interactive nil)
  (mark-common 'l)
  (message "Line region marked")
)

(defun mark-m ()
  "Mark stream region"
  (interactive nil)
  (if (eq reg-flag 'm)
      (progn (remove-mark-hook) (setq reg-flag nil) (message "Region mark released"))
    (progn (mark-common 'm) (message "Stream region marked"))
    )
)

(defun mark-common (new-reg-flag)
  "Mark stream/line/rectangle region common routine"
  (set-mark-command nil)
  (if reg-flag
    (remove-mark-hook)
  )
  (setq reg-point (point))
  (setq reg-flag new-reg-flag)
  (install-mark-hook)
)

(defun mark-release ()
  "Unmark region"
  (interactive nil)
  (remove-mark-hook)
  (message "Region mark released")
)

(defun grey-minus ()
  "Perform functions of Grey Minus in Brief style."
  (interactive nil)
  (cond
   ((eq reg-flag 'c)
    (kill-rectangle reg-point (point))
    (setq reg-in-scrap-flag 'c)
    (remove-mark-hook)
    (message "Rectangle region cut to scrap")
    )
   ((eq reg-flag 'm)
    (kill-region reg-point (point))
    (setq reg-in-scrap-flag 'm)
    (remove-mark-hook)
    (message "Stream region cut to scrap")
    )
   ((eq reg-flag 'l)
    (if (< (point) reg-point)
	(cut-lines (point) reg-point)
      (cut-lines reg-point (point))
      )
    (setq reg-in-scrap-flag 'l)
    (remove-mark-hook)
    (message "Line region cut to scrap")
    )
   (mark-active
    (kill-region (point) (mark))
    (setq reg-in-scrap-flag 'm)
    (and transient-mark-mode mark-active (deactivate-mark))
    (message "Marked region cut to scrap")
    )
   (t
    (delete-line)
    (setq reg-in-scrap-flag 'l)
    )
   )
  (setq reg-flag nil)
)

(defun grey-delete ()
  "Perform functions of Grey Delete in Brief style."
  (interactive nil)
  (cond
   ((eq reg-flag 'c)
    (kill-rectangle reg-point (point))
    (remove-mark-hook)
    (setq kill-ring (cdr kill-ring))
    (message "Rectangle region deleted")
    )
   ((eq reg-flag 'm)
    (kill-region reg-point (point))
    (remove-mark-hook)
    (setq kill-ring (cdr kill-ring))
    (message "Stream region deleted")
    )
   ((eq reg-flag 'l)
    (if (< (point) reg-point)
	(cut-lines (point) reg-point)
      (cut-lines reg-point (point))
      )
    (remove-mark-hook)
    (setq kill-ring (cdr kill-ring))
    (message "Line region deleted")
    )
   (mark-active
    (kill-region (point) (mark))
    (setq kill-ring (cdr kill-ring))
    (and transient-mark-mode mark-active (deactivate-mark))
    (message "Marked region deleted")
    )
   (t
    (delete-char 1)
    )
   )
  (setq reg-flag nil)
  )




(defun grey-minus-to-reg (char)
  "Perform functions of Grey Minus in Brief style (to register)."
  (interactive "cCut region to register:")
  (cond
    ((eq reg-flag 'c)
      (copy-rectangle-to-register char reg-point (point) t)
      (setq reg-in-scrap-flag 'c)
      (remove-mark-hook)
      (message (format "Rectangle region cut to register %c" char))
    )
    ((eq reg-flag 'm)
      (copy-to-register char reg-point (point) t)
      (setq reg-in-scrap-flag 'm)
      (remove-mark-hook)
      (message (format "Stream region cut to register %c" char))
    )
    ((eq reg-flag 'l)
      (if (< (point) reg-point)
          (copy-to-register char
                            (beg-line-reg-point (point))
                            (end-line-reg-point reg-point) t)
          (copy-to-register char
                            (beg-line-reg-point reg-point)
                            (end-line-reg-point (point)) t)
      )
      (setq reg-in-scrap-flag 'l)
      (remove-mark-hook)
      (message (format "Line region cut to register %c" char))
    )
    (t
      (copy-to-register char
                        (beg-line-reg-point (point))
                        (end-line-reg-point (point)) t)

      (setq reg-in-scrap-flag 'l)
      (message (format "Simple line cut to register %c" char))
    )
  )
  (setq reg-flag nil)
)

(defun grey-plus ()
  "Perform functions of Grey Plus in Brief style."
  (interactive nil)
  (cond
    ((eq reg-flag 'c)
      (setq killed-rectangle (extract-rectangle reg-point (point)))
      (setq reg-in-scrap-flag 'c)
      (remove-mark-hook)
      (message "Rectangle region copied to scrap")
    )
    ((eq reg-flag 'm)
      (copy-region-as-kill reg-point (point))
      (setq reg-in-scrap-flag 'm)
      (remove-mark-hook)
      (message "Stream region copied to scrap")
    )
    ((eq reg-flag 'l)
      (if (< (point) reg-point)
	  (copy-lines (point) reg-point)
	  (copy-lines reg-point (point))
      )
      (setq reg-in-scrap-flag 'l)
      (remove-mark-hook)
      (message "Line region copied to scrap")
    )
   (mark-active
      (copy-region-as-kill (point) (mark))
      (setq reg-in-scrap-flag 'm)
      (and transient-mark-mode mark-active (deactivate-mark))
      (message "Marked region copied to scrap")
    )
    (t
      (copy-line)
      (setq reg-in-scrap-flag 'l)
    )
  )
  (setq reg-flag nil)
)

(defun grey-plus-to-reg (char)
  "Perform functions of Grey Plus in Brief style (to register)."
  (interactive "cCopy region to register:")
  (cond
    ((eq reg-flag 'c)
      (copy-rectangle-to-register char reg-point (point))
      (setq reg-in-scrap-flag 'c)
      (remove-mark-hook)
      (message (format "Rectangle region copy to register %c" char))
    )
    ((eq reg-flag 'm)
      (copy-to-register char reg-point (point))
      (setq reg-in-scrap-flag 'm)
      (remove-mark-hook)
      (message (format "Stream region copy to register %c" char))
    )
    ((eq reg-flag 'l)
      (if (< (point) reg-point)
          (copy-to-register char
                            (beg-line-reg-point (point))
                            (end-line-reg-point reg-point))
          (copy-to-register char
                            (beg-line-reg-point reg-point)
                            (end-line-reg-point (point)))
      )
      (setq reg-in-scrap-flag 'l)
      (remove-mark-hook)
      (message (format "Line region copy to register %c" char))
    )
    (t
      (copy-to-register char
                        (beg-line-reg-point (point))
                        (end-line-reg-point (point)))

      (setq reg-in-scrap-flag 'l)
      (message (format "Simple line copy to register %c" char))
    )
  )
  (setq reg-flag nil)
)

(defun insert-key ()
  "Perform functions of Ins in Brief style."
  (interactive nil)
  (cond
    ((eq reg-in-scrap-flag 'c)
      (yank-rectangle)
      (message "Rectangle region inserted")
    )
    ((eq reg-in-scrap-flag 'm)
      (yank)
      (message "Stream region inserted")
    )
    ((eq reg-in-scrap-flag 'l)
      (save-excursion
	(beginning-of-line)
	(yank)
      )
      (message "Line region inserted")
    )
    (t
     (clipboard-yank)
;      (message "Nothing to insert")
    )
  )
)

(defun install-mark-hook ()
  (setq rm-overlay-list nil)
  (setq rm-force (eq major-mode 'picture-mode))
  (setq old-transient-mark-mode transient-mark-mode)
  (setq old-ctrl-g (key-binding "\C-g"))
  (local-set-key "\C-g" '(lambda()
                           (interactive nil)
                           (remove-mark-hook)
                           (funcall old-ctrl-g)
                         )
  )
  (setq transient-mark-mode nil)
  (add-hook 'post-command-hook 'mark-post-command-hook)
)

(defun remove-mark-hook ()
  (remove-hook 'post-command-hook 'mark-post-command-hook)
  (setq transient-mark-mode old-transient-mark-mode)
  (local-set-key "\C-g" old-ctrl-g)
  (mapcar (function delete-overlay) rm-overlay-list)
  (and transient-mark-mode mark-active (deactivate-mark))
)

(defun mark-post-command-hook ()
  (condition-case info
    (save-excursion
      (cond
       ((eq reg-flag 'm)
        (mark-piece reg-point (point))
       )
       ((eq reg-flag 'l)
        (mark-piece (beg-line-reg-point reg-point)
                    (end-line-reg-point (point)))
       )
       ((eq reg-flag 'c)
        ;; Calculate the rectangular region represented by point and
        ;; reg-point, putting beg in the north-west corner and end in
        ;; the south-east corner.
        (let ((beg reg-point) (end (point)))
          (and (> beg end)
               (setq beg (prog1 end (setq end beg)))     ; beg <-> end
          )
          (let ((beg-col (save-excursion (goto-char beg) (current-column)))
                (end-col (save-excursion (goto-char end) (current-column)))
               )
            (and (> beg-col end-col)
                 (setq beg-col (prog1 end-col (setq end-col beg-col))
                       beg (save-excursion
                             (goto-char beg)
                             (move-to-column beg-col rm-force)
                             (point)
                           )
                       end (save-excursion
                             (goto-char end)
                             (move-to-column end-col rm-force)
                             (point)
                           )
                 )
            )
            (let ((old rm-overlay-list) (new nil) overlay)
              ;; Iterate over each line within the rectangle.
              (goto-char beg)
              (while (< (point) end)
                (let ((beg (point))
                      (end (progn
                             (move-to-column end-col rm-force)
                             (point)
                           )
                      )
                     )
                  ;; Trim old leading overlays.
                  (while (and old
                              (setq overlay (car old))
                              (< (overlay-start overlay) beg)
                              (/= (overlay-end overlay) end)
                         )
                    (delete-overlay overlay)
                    (setq old (cdr old))
                  )
                  ;; Reuse an overlay if possible, otherwise create one.
                  (if (and old
                           (setq overlay (car old))
                           (or (= (overlay-start overlay) beg)
                               (= (overlay-end overlay) end)
                           )
                      )
                    (progn
                      (move-overlay overlay beg end)
                      (setq new (cons overlay new) old (cdr old))
                    )
                    (setq overlay (make-overlay beg end))
                    (overlay-put overlay 'face 'region)
                    (setq new (cons overlay new))
                  )
                  (forward-line 1)
                  (or (eobp) (move-to-column beg-col rm-force)))
              )
              ;; Trim old trailing overlays.
              (mapcar (function delete-overlay) old)
              (setq rm-overlay-list (nreverse new))
            )
          )
        )
       )
       (t
        nil
       )
      )
    )
    (error
     (remove-mark-hook)
     (ding)
     (message "mark error: %s" info)
    )
  )
)

(defun mark-piece (beg end)
  (let ((old rm-overlay-list) (new nil) overlay)
    ;; Trim old leading overlays.
    (while (and old
                (setq overlay (car old))
                (< (overlay-start overlay) beg)
                (/= (overlay-end overlay) end)
           )
      (delete-overlay overlay)
      (setq old (cdr old))
    )
    ;; Reuse an overlay if possible, otherwise create one.
    (if (and old
             (setq overlay (car old))
             (or (= (overlay-start overlay) beg)
                 (= (overlay-end overlay) end)
             )
        )
      (progn
        (move-overlay overlay beg end)
        (setq new (cons overlay new) old (cdr old))
      )
      (setq overlay (make-overlay beg end))
      (overlay-put overlay 'face 'region)
      (setq new (cons overlay new))
    )
    (mapcar (function delete-overlay) old)
    (setq rm-overlay-list (nreverse new))
  )
)


;;; ------------------------------------------------------------- &mcr ---
;                                                          KEYBOARD MACROS
(defun define-keystroke-macro ()
  "Start/End defenition of keyboard macro."
  (interactive nil)
  (if keyb-buffer-status
    (progn
      (end-kbd-macro nil)
      (setq keyb-macro-defined t)
      (setq keyb-buffer-status nil)
    )
    (progn
      (if keyb-macro-defined
          (if (y-or-n-p "Keyboard macro defined. Do you want overwrite it ? ")
            (define-keystroke-macro-internal)
          )
        (define-keystroke-macro-internal)
      )
    )
  )
)

(defun define-keystroke-macro-internal ()
  (if (string= window-system "x")
      (global-set-key [f8]  'dummy-execut-keystroke-macro)
    (global-set-key ExMac 'dummy-execut-keystroke-macro)
  )
  (start-kbd-macro nil)
  (if (string= window-system "x")
      (global-set-key [f8]  'execut-keystroke-macro)
    (global-set-key ExMac 'execut-keystroke-macro)
  )
  (setq keyb-buffer-status t)
)

(defun dummy-execut-keystroke-macro ()
  "Dummy execution keyboard macro in macro defenition process."
  (interactive nil)
  (setq keyb-buffer-status t)
  (error "Execution keyboard macro during macro definition !!!")
)

(defun execut-keystroke-macro ()
  "Execution of keyboard macro."
  (interactive nil)
  (cond (keyb-buffer-status
	 (message "Can not execute keyboard macro while definition it !!!")
	)
	(t
          (if (string= window-system "x")
            (global-set-key [f8]  'dummy-function)
            (global-set-key ExMac 'dummy-function)
          )
	  (setq rpt current-prefix-arg)
	  (if (not rpt)
	    (setq rpt 1)
	  )
	  (while (> rpt 0)
	    (call-last-kbd-macro)
	    (setq rpt (1- rpt))
	  )
          (if (string= window-system "x")
            (global-set-key [f8]  'execut-keystroke-macro)
            (global-set-key ExMac 'execut-keystroke-macro)
          )
        )
   )
)

(defun read-keystroke-macro(filename)
  "Read keyboard macro from file."
  (interactive "fFile name with keyboard macro : ")
  (cond (keyb-macro-defined
	 (cond ((y-or-n-p "Keyboard macro defined. Do you want overwrite it ? ")
		(if (load-file filename)
		    (setq keyb-macro-defined t)
		)
               )
         )
        )
	(t
	 (if (load-file filename)
	     (setq keyb-macro-defined t)
	 )
        )
  )
)

(defun save-keystroke-macro ()
  "Save keyboard macro (if defined) to file."
  (interactive nil)
  (cond (keyb-macro-defined
	  (call-interactively 'save-keystroke-macro1)
	)
	(t
          (message "Keyboard macro not defined")
	)
  )
)

(defun save-keystroke-macro1 (filename)
  "Real saving keyboard macro to file."
  (interactive "FFile name for saving keyboard macro : ")
  (set-buffer (get-buffer-create "*last-keyb-macro*"))
  (setq p1 (point))
  (insert (format "(setq last-keystroke-macro %s)" (prin1-to-string last-keystroke-macro)))
  (setq p2 (point))
  (write-region p1 p2 filename)
  (kill-buffer "*last-keyb-macro*")
)


;;; ============================================================= &cfs ===
;=========================================== Complementary functions  ====

(defun next-buffer_ ()
  ""
  (interactive)
  (bury-buffer (current-buffer))
  (switch-to-buffer (nth 0 (buffer-list)))
  (if (string-match "*" (buffer-name))
	  (next-buffer)))

(defun previous-buffer_ (&optional buf)
  "Select buffer BUF, or the last one in the buffer list.
This function is the opposite of `bury-buffer'."
; Credit: Joerg Erdmenger
  (interactive)
  (or buf (setq buf (car (reverse (buffer-list)))))
  (switch-to-buffer buf)
  (if (string-match "*" (buffer-name))
	  (previous-buffer)))


;;
;; for control-cursor-up key
;;

(defun pc-keys-scroll-down-one-line ()

  "Scrolls the visible part of the buffer one line down."

  (interactive)
  (let ((scroll-in-place nil))
    (scroll-down 1))
  )

;;
;; for control-cursor-down key
;;

(defun pc-keys-scroll-up-one-line ()

  "Scrolls the visible part of the buffer one line up."

  (interactive)
  (let ((scroll-in-place nil))
    (scroll-up 1))
  )

;;
;; for shift-cursor-up
;;

(defun pc-keys-previous-line ()

  "Scrolls one line but does not move the cursor relative to
window. Instead, the beginning of the window is changed."

  (interactive)
  (let ((scroll-in-place nil))
    (scroll-down 1)
    (previous-line 1)))

;;
;; for shift-cursor-down
;;

(defun pc-keys-next-line ()

  "Scrolls one line but does not move the cursor relative to
window. Instead, the beginning of the window is changed."

  (interactive)
  (let ((scroll-in-place nil))
    (scroll-up 1)
    (previous-line -1)))


;;
;; for shift-control-cursor-down key
;;

(defun pc-keys-scroll-other-window-one-line-up ()

  "As the name implies this is similar to scroll-other-window."

  (interactive)
  (let ((scroll-in-place nil))
    (scroll-other-window 1)))

;;
;; for shift-control-cursor-up key
;;

(defun pc-keys-scroll-other-window-one-line-down ()

  "As the name implies this is similar to scroll-other-window."

  (interactive)
  (let ((scroll-in-place nil))
    (scroll-other-window -1)))

;;
;; for shift-control-page-down key
;;

(defun pc-keys-scroll-other-window-up ()

  "As the name implies this is similar to scroll-other-window."

  (interactive)

  (other-window 1)
  (scroll-up)
  (other-window -1))

;;
;; for shift-control-page-up key
;;

(defun pc-keys-scroll-other-window-down ()

  "As the name implies this is similar to scroll-other-window."

  (interactive)

  (other-window 1)
  (scroll-down)
  (other-window -1))

;;; ------------------------------------------------------------- &dnt ---
;                                                  Date & Time & file name

;;;======================================================================
;;; Functions to insert the date, the time, and the date and time at
;;; point.  Useful for keeping records and automatically creating
;;; program headers
;;; Credit: Anthony Tsakiris
;;;======================================================================
(defvar insert-time-format "%H:%M:%S"
  "*Format for \\[insert-time] (c.f. 'format-time-string' for how to
format).")

(defvar insert-date-format "%Y.%m.%d" ;" %a %d %b %Y"
  "*Format for \\[insert-date] (c.f. 'format-time-string' for how to
format).")

(defun insert-time ()
  "Insert the current time according to the variable \"insert-time-format\"."
  (interactive "*")
  (insert (format-time-string insert-time-format (current-time)))
  )

(defun insert-date ()
  "Insert the current date according to the variable \"insert-date-format\"."
  (interactive "*")
  (insert (format-time-string insert-date-format (current-time)))
  )

(defun insert-date-and-time ()
  "Insert the current date according to the variable \"insert-date-format\",
then a space, then the current time according to the variable
\"insert-time-format\"."
  (interactive "*")
  (progn
    (insert-date)
    (insert " ")
    (insert-time))
  )

(defun insert-current-file-name ()
  (interactive)
  (insert (buffer-file-name (current-buffer))))


;;; -------------------------------------------------------------- &cc ---
;                                                            Case Changing

;
; Change cases for current word or the marked region
;

(defun lowercase-region-or-word ()
  "lowercase the word from the current position or the marked region"
  (interactive)
  (if mark-active
      (downcase-region (region-beginning) (region-end))
;     (progn
;       (forward-word -1)
;       (downcase-word 1)
;       )
    (downcase-word 1)
  ))

(defun uppercase-region-or-word ()
  "uppercase the word from the current position or the marked region"
  (interactive)
  (if mark-active
      (upcase-region (region-beginning) (region-end))
    (upcase-word 1)))

(defun initials-uppercase-region-or-word ()
  "Upcase the initial of each word in the region."
  (interactive)
  (if mark-active
      (capitalize-region (region-beginning) (region-end))
    (capitalize-word 1))
  )

;;; ============================================================= &fmt ===
;;; ======================================================= Formatting ===

; Here are my revised request and the test results:
; 
; Say I have a line and cusor position like below:
; 
; word1                                 word2 ...
;         ^
; After I use delete word, I want to get:
; word1   word2 ...
; 
; i.e., only the space between the cursor and word2 is deleted, not with
; word2. I found it very inconvenient for me what emacs is doing.
; 
; 
; The results from the answers:
; M-x kill-word: word2 also get killed.
; word1   ...
; 
; M-SPC:  space before the cursor get killed
; word1 word2 ...
; 
; fixup-whitespace: not quite to the point
; 
; M-\:  all space get killed
; word1word2 ...

(defun kill-word-or-whitespace (arg)
  "Kill characters forward until encountering the end of a word or whitespace.
With argument, kill that many words."
  (interactive "*p")
  (save-excursion
    (let ((start (point))
          (next-word-end (progn (forward-word arg) (point)))
          (next-word-start (progn (backward-word arg) (point))))
      (kill-region start
                   (if (if (> arg 0)
                           (<= next-word-start start)
                         (>= next-word-start start))
                       next-word-end
                       next-word-start)))))

(defun backward-kill-word-or-whitespace (arg)
"Kill characters backward until reaching the beginning of a word or
whitespace.  With argument, kill that many words."

  (interactive "*p")
  (kill-word-or-whitespace (- arg)))

(defun brief-tab (number-of-spaces)
"if no region is active TAB works as usual,
if a region is active TAB calls indent-region on the region,
possibliy with a prefix argument (default 8)"
; Credit: Frank
  (interactive "P")
  (if mark-active
      (indent-region (region-beginning)
                     (region-end)
                     (or number-of-spaces tab-width))
    (funcall (key-binding (char-to-string 9)))))

;; todo: brief-tab-back

(defun unfill-paragraph ()
  "Undo filling current paragraph."
  (interactive)
  (backward-paragraph)
  (let ((fill-column (point-max)))
    (fill-paragraph nil))
  (forward-paragraph)			; to blank line
  (forward-line)			; to next paragraph
  )

(defun unfill-buffer ()
  "Undo filling for all paragraphs."
; Credit: Alex Schroeder
  (interactive)
  (goto-char (point-min))
  (let ((fill-column (point-max)))
    (fill-paragraph nil)
    (while (< (point) (point-max))
      (forward-paragraph)
      (fill-paragraph nil))))

(defun brief-split{-to-next-line()
  "Move all trailing '{' to the next line in the whole buffer."
; Credit: Christoph Conrad
  (interactive)
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-min))
      (while (re-search-forward "\\(.*\\){[ \t]*$" nil t)
        (when (null (string-match "^[ \t]*$"  (match-string 1)))
          (replace-match "\\1" nil nil)
          (reindent-then-newline-and-indent)
          (insert "{"))))))

(defun brief-join{-with-previous-line()
  "Join all separate '{' to the previous line in the whole buffer."
  (interactive)
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-min))
      (while (re-search-forward "^[ \t]*{[ \t]*$" nil t)
          (delete-indentation)
      ))))

(defun brief-spaces-around-parens nil
  "adds spaces, so foo.bar(thing, other); becomes foo.bar( thing, other );"
; Credit: Edric M Ellis
  (interactive)
  (save-excursion
	(goto-char (point-min))
	(while (re-search-forward "(\\([^ )]\\)" nil t)
	  (replace-match "( \\1"))
	(goto-char (point-min))
	(while (re-search-forward "\\([^ (]\\))" nil t)
	  (replace-match "\\1 )"))))

(defun brief-spaces-before-if-parens nil
  "adds spaces, so if(thing, other); becomes if (thing, other);"
  (interactive)
  (save-excursion
	(goto-char (point-min))
	(while (re-search-forward "\\(if\\|while\\)(" nil t)
	  (replace-match "\\1 ("))))

(defun brief-nospaces-around-parens nil
  "remove spaces, so foo.bar ( thing, other ); becomes foo.bar(thing, other);"
  (interactive)
  (save-excursion
	(goto-char (point-min))
	(while (re-search-forward "( " nil t)
	  (replace-match "("))
	(goto-char (point-min))
	(while (re-search-forward " (" nil t)
	  (replace-match "("))
	(goto-char (point-min))
	(while (re-search-forward " )" nil t)
	  (replace-match ")"))))

;;; -------------------------------------------------------------- &qt ---
;                                                                  Quoting

(defvar quote-string "> "
  "String used for paragraph quoting: 
`quote-region', which mapped to \\[quote-region], and, 
`quote-reformat', which mapped to \\[quote-reformat] .")

(defun quote-reformat ()
  "Reformat a paragraph of indented quotation,  
   using the variable `quote-string'."
  (interactive)
  (beginning-of-line 1)
  (if (looking-at "\n")
      (forward-line 1))
  (let ((bofp (point)))
    (skip-chars-forward quote-string)
    (let ((fill-prefix (buffer-substring bofp (point))))
      (fill-paragraph nil))))


(defun quote-region(b e)
  "Quote the mouse selected *lines* using the variable `quote-string'"
  (interactive "r")
  (forward-line -1)
  (setq e1 (point))
  (forward-line)
  (string-rectangle b e1 quote-string)
  )

(defun quote-region2(b e)
  "Quote the mouse selected *lines*"
  (interactive "r")
  (forward-line -1)
  (setq e1 (point))
  (forward-line)
  (insert "`-----\n")
  (string-rectangle b e1 "| ")
  (goto-char b)
  (insert ",-----\n")
  (goto-char e)
  (forward-line 2)
  )

;;; ============================================================= &sen ===

(global-set-key [kp-7] 'gohome)
(global-set-key [kp-1] 'goend)
(global-set-key [kp-9] 'pgup)
(global-set-key [kp-3] 'pgdn)
(global-set-key [kp-5] 'recenter)
(global-set-key [kp-8] 'previous-line)
(global-set-key [kp-2] 'next-line)
(global-set-key [kp-4] 'left-char)
(global-set-key [kp-6] 'right-char)

;;(global-set-key [M-f1]	'(lambda() (interactive) (manual-entry (current-word))))
;;(global-set-key [help help]  'help-for-help)               ; Help Help
;;(global-set-key [help]       'help-command)                ; Help
(global-set-key "h" 'help-command)
(global-set-key [f12] 'menu-bar-open)

;;; urxvt terminal
(when (string= (getenv "TERM") "rxvt-unicode")
	;; urxvt
        (global-set-key "Ok" 'grey-plus)
	(global-set-key "Om" 'grey-minus)
	(global-set-key "Op" 'insert-key)
	(global-set-key "[2~" 'insert-key)
	(global-set-key "On" 'grey-delete)
	(global-set-key "[3~" 'grey-delete)
	(global-set-key "Oj" 'undo)
;;
	(global-set-key "Ow" 'gohome)
	(global-set-key "Oq" 'goend)
	(global-set-key "Oy" 'pgup)
	(global-set-key "Os" 'pgdn)
	(global-set-key "Ox" 'previous-line)
	(global-set-key "Or" 'next-line)
	(global-set-key "Ot" 'left-char)
	(global-set-key "Ov" 'right-char)
	)

;;; linux console
(when (string= (getenv "TERM") "linux")
	;; linux console
	(global-set-key "Ol" 'grey-plus)
	(global-set-key "OS" 'grey-minus)
	(global-set-key "Op" 'insert-key)
	(global-set-key "[2~" 'insert-key)
	(global-set-key "On" 'grey-delete)
	(global-set-key "[3~" 'grey-delete)
	(global-set-key "OR" 'undo)
;;
	(global-set-key "Ow" 'gohome)
	(global-set-key "Oq" 'goend)
	(global-set-key "Oy" 'pgup)
	(global-set-key "Os" 'pgdn)
	(global-set-key "Ox" 'previous-line)
	(global-set-key "Or" 'next-line)
	(global-set-key "Ot" 'left-char)
	(global-set-key "Ov" 'right-char)
	)

;================================= Reading of saved emacs environment ====
	
(and
  (file-exists-p   save-environment-filename)
  (file-readable-p save-environment-filename)
  (load-file       save-environment-filename)
  (setq x-select-enable-clipboard t)
)

;;; end of brief.el


