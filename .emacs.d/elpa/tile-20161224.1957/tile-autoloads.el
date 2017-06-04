;;; tile-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "tile" "tile.el" (22832 21941 746667 750000))
;;; Generated autoloads from tile.el

(autoload 'tile-select "tile" "\
Select a tile strategy by name.

\(fn)" t nil)

(autoload 'tile "tile" "\
Tile WINDOW-COUNT windows using STRATEGY.

STRATEGY defaults to the return value
of `(tile-get-next-strategy)' and WINDOW-COUNT defaults to the
current window count.

\(fn &key (WINDOW-COUNT (length (window-list nil -1 nil))) (CYCLER tile-cycler) (STRATEGY (tile-get-next-strategy cycler)))" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; tile-autoloads.el ends here
