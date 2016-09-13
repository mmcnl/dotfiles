;;;;;;;;;;;;;;;;;;;;;;; recentf ;;;;;;;;;
(with-eval-after-load 'recent-f
  (add-to-list 'recentf-exclude "TAGS$")
  (add-to-list 'recentf-exclude "undo-tree")

  ;; run every 20 minutes
  (run-with-timer 0 (* 20 60) 'recentf-cleanup)

  ;; run when idle for 2 minutes
  (setq recentf-auto-cleanup 120)
  )
;;;;;;;;;;;;;;;;;;; kill ring ;;;;;;;;;
(setq kill-ring-max 500)
;; persist kill-ring between restarts
;; http://emacs.stackexchange.com/a/642/10014
(savehist-mode 1)
(add-to-list 'savehist-additional-variables 'kill-ring)

;; https://github.com/syl20bnr/spacemacs/issues/6203#issuecomment-223558416
(setq evil-in-single-undo t)

(use-package undohist
  :init
  (setq undohist-directory (expand-file-name "undo-history" spacemacs-cache-directory))
  :config
  (undohist-initialize))
