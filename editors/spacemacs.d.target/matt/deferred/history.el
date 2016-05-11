;;;;;;;;;;;;;;;;;;;;;;; recentf ;;;;;;;;;
(with-eval-after-load 'recent-f
  (add-to-list 'recentf-exclude "TAGS$")
  (add-to-list 'recentf-exclude "undo-tree")

  ;; run when idle for 5 minutes
  (setq recentf-auto-cleanup 600)
  )
;;;;;;;;;;;;;;;;;;; kill ring ;;;;;;;;;
(setq kill-ring-max 500)
;; persist kill-ring between restarts
;; http://emacs.stackexchange.com/a/642/10014
(savehist-mode 1)
(add-to-list 'savehist-additional-variables 'kill-ring)

(use-package undohist
  :init
  (setq undohist-directory (expand-file-name "undo-history" spacemacs-cache-directory))
  :config
  (undohist-initialize))
