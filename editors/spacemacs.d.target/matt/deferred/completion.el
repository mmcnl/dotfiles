(setq global-company-mode t)

(with-eval-after-load 'company
  (setq company-idle-delay 0.4)
  (setq company-minimum-prefix-length 1)
  (setq company-tooltip-limit 15)

  (setq company-etags-ignore-case t)
  (setq company-dabbrev-ignore-case t)
  (setq company-dabbrev-code-ignore-case t)

  (define-key company-active-map (kbd "C-w") 'backward-delete-word)
  )

(add-to-list 'hippie-expand-try-functions-list 'try-expand-dabbrev-visible)
