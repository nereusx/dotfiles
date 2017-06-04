;;; html5-schema-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "html5-schema" "html5-schema.el" (22832 20875
;;;;;;  642562 22000))
;;; Generated autoloads from html5-schema.el

(when load-file-name (let* ((dir (file-name-directory load-file-name)) (file (expand-file-name "locating-rules.xml" dir))) (eval-after-load 'rng-loc `(progn (add-to-list 'rng-schema-locating-files-default 'file) (add-to-list 'rng-schema-locating-files ,file) (put 'http://whattf\.org/datatype-draft 'rng-dt-compile #'nxml-html5-dt-compile)))))

(add-to-list 'auto-mode-alist '("\\.html?\\'" . nxml-mode))

(autoload 'nxml-html5-dt-compile "html5-schema" "\


\(fn NAME PARAMS)" nil nil)

;;;***

;;;### (autoloads nil nil ("html5-schema-pkg.el") (22832 20875 661561
;;;;;;  603000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; html5-schema-autoloads.el ends here
