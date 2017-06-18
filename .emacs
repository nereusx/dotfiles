
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(setq backup-directory-alist `(("." . "~/.backup/saves")))
(add-to-list 'load-path "~/.emacs.d/lisp")
(setq default-tab-width 4)
(load-library "brief-mode")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes (quote (tango-dark)))
 '(package-selected-packages
   (quote
	(vimrc-mode perl6-mode oberon msvc vala-mode modern-cpp-font-lock js3-mode go-mode lua-mode forth-mode glsl-mode elisp-docstring-mode ada-ref-man ada-mode gnu-apl-mode flymd flymake-vala flymake-shell flymake-phpcs flymake-php flymake-perlcritic flymake-lua flymake-css flymake-cppcheck flylisp flycheck-rust flycheck-perl6 flycheck-cstyle flycheck-css-colorguard flycheck-clangcheck flycheck-clang-tidy flycheck c-eldoc shell-here shell-current-directory shell-command popup-edit-menu org-cua-dwim org-bookmark-heading org ac-php ac-c-headers tile php-mode json-mode html5-schema docbook cobol-mode wconf crisp)))
 '(safe-local-variable-values
   (quote
	((indent-style . tab)
	 (indent_style . tab)
	 (tab_width . 4)
	 (charset . utf-8)
	 (indent . 4)
	 (tab . 4)
	 (encoding . utf8))))
 '(save-place-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "PragmataPro" :foundry "fsdf" :slant normal :weight normal :height 117 :width normal)))))
