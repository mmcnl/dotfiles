;; remove some of the useless items from osx menu bar
;; http://emacs.stackexchange.com/a/960/10014
(define-key global-map [menu-bar options] nil)
(define-key global-map [menu-bar tools] nil)
(define-key global-map [menu-bar text] nil)

(remove-hook 'menu-bar-update-hook 'undo-tree-update-menu-bar)
(remove-hook 'menu-bar-update-hook 'menu-bar-update-buffers)
