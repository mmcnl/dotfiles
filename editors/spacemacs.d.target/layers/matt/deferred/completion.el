(setq global-company-mode t)

(with-eval-after-load 'company
  (setq company-idle-delay 0.3)
  (setq company-minimum-prefix-length 2)
  (setq company-tooltip-limit 20)

  ;; (setq company-dabbrev-code-everywhere t)
  ;; (setq company-dabbrev-code-ignore-case t)
  ;; (setq company-dabbrev-code-modes nil)
  ;; (setq company-dabbrev-code-other-buffers 'all)
  ;; (setq company-dabbrev-code-other-buffers (quote all))

  (setq company-dabbrev-ignore-buffers "\\`\\'")
  (setq company-dabbrev-ignore-case t)
  (setq company-dabbrev-other-buffers 'all)
  (setq company-dabbrev-char-regexp "\\(\\sw\\|\\s_\\|_\\|-\\)")
  (setq company-etags-ignore-case t)

  (define-key company-active-map (kbd "C-w") 'backward-delete-word)
  (define-key company-active-map (kbd "C-h") 'backward-delete-char)
  )

(add-to-list 'hippie-expand-try-functions-list 'try-expand-dabbrev-visible)
(define-key evil-insert-state-map (kbd "C-l") 'hippie-expand)
