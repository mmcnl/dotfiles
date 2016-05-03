;; basic editing
(delete-selection-mode 1)

;; navigation
(global-evil-matchit-mode 1)
(setq avy-keys '(?f ?d ?s ?a ?g ?h ?u ?k ?l ?q ?w ?e ?r ?t ?y ?i ?o ?j))
;; select jump targets from all windows
(setq avy-all-windows t)

;; text appearance
(show-paren-mode 1)
(show-smartparens-global-mode -1)
(smartparens-mode t)
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
