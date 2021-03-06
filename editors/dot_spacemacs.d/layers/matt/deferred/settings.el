;; text appearance
(show-paren-mode 1)
(show-smartparens-global-mode -1)
(smartparens-mode t)

;; make dired default to sorting by time https://superuser.com/a/1212406/646549
(setq dired-listing-switches "-lt")

(setq-default truncate-lines t)
(spacemacs/toggle-visual-line-navigation-on)
(setq whitespace-style (quote
                        (face tabs trailing
                              space-before-tab
                              lines-tail indentation
                              space-after-tab tab-mark )))
;; questions
(fset 'yes-or-no-p 'y-or-n-p)
;; http://emacs.stackexchange.com/questions/14802/never-keep-current-list-of-tags-tables-also
(setq tags-add-tables nil)

;; Set the maximum length (in characters) for key descriptions (commands or
;; prefixes). Descriptions that are longer are truncated and have ".." added.
(setq which-key-max-description-length 40)

;; Set to t to show the count of keys shown vs. total keys in the mode line.
(setq which-key-show-remaining-keys t)

;; https://github.com/syl20bnr/spacemacs/blob/master/doc/FAQ.org#why-is-spacemacs-hanging-on-startup
(setq tramp-ssh-controlmaster-options
      "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")
