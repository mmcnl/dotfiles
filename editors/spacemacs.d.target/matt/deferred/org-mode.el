(setq org-startup-indented 1)
(with-eval-after-load 'org
  (make-face 'org-mode-mellow-default)
  (set-face-attribute 'org-mode-mellow-default nil :foreground "#5A4369")

  (add-hook 'org-mode-hook
            (function (lambda ()
                        (buffer-face-mode)
                        (buffer-face-set 'org-mode-mellow-default)
                        (flycheck-mode -1)
                        (whitespace-mode -1)
                        (spacemacs/toggle-aggressive-indent-off)

                        (define-key org-mode-map [(control tab)] 'mybuffers-switch)
                        (set (make-local-variable 'company-backends)
                             '((
                                company-dabbrev
                                company-ispell
                                )))
                        )) t)

  (evil-define-key 'normal evil-org-mode-map
    "O" 'evil-open-above
    (kbd "RET") 'insert-and-indent-line-above
    )
  (evil-define-key 'visual evil-org-mode-map
    "<" 'org-metaleft
    ">" 'org-metaright
    )

  )
(global-set-key (kbd "C-0") (lambda() (interactive)(find-file "~/Dropbox/org/ponder-rec.org")))
(global-set-key (kbd "C-9") (lambda() (interactive)(find-file "~/Dropbox/org/todo.org")))
