(with-eval-after-load 'org
  (setq-default org-startup-indented 1)
  ;; https://github.com/syl20bnr/spacemacs/issues/5474#issuecomment-195973923
  (setq org-planning-line-re "")

  (make-face 'org-mode-mellow-default)
  (set-face-attribute 'org-mode-mellow-default nil :foreground "#6A6F7C")

  (spacemacs|diminish buffer-face-mode)
  (add-hook 'org-mode-hook
            (function (lambda ()
                        (buffer-face-mode)
                        (buffer-face-set 'org-mode-mellow-default)
                        (flycheck-mode -1)
                        (flyspell-mode -1)
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
(global-set-key (kbd "C-0") (lambda() (interactive)(find-file "~/Dropbox/org/inqyre.org")))
(global-set-key (kbd "C-9") (lambda() (interactive)(find-file "~/Dropbox/org/todo.org")))
