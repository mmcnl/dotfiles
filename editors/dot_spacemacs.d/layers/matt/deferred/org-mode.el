(defun my-org-setup ()
  (interactive)
  ;; (setq-default org-startup-indented 1)
  ;; https://github.com/syl20bnr/spacemacs/issues/5474#issuecomment-195973923
  ;; (setq org-planning-line-re "")

  ;; (setq ispell-really-hunspell t)
  ;; (spacemacs|diminish buffer-face-mode)
  (add-hook 'org-mode-hook
            (function (lambda ()
                        ;; (buffer-face-mode)
                        ;; (buffer-face-set 'org-mode-mellow-default)
                        (flycheck-mode -1)
                        (flyspell-mode -1)
                        (whitespace-mode -1)
                        ;; (spacemacs/toggle-aggressive-indent-off)

                        (evil-define-key 'normal evil-org-mode-map
                          "O" 'org-insert-heading-then-insert
                          "o" 'org-insert-heading-after-then-insert
                          (kbd "C-p") 'org-metaup
                          (kbd "C-n") 'org-metadown
                          (kbd "C-n") 'org-metadown
                          ;; (kbd "RET") 'insert-and-indent-line-above
                          (kbd "RET") 'org-meta-return
                          )
                        (define-key org-mode-map [(control tab)] 'mybuffers-switch)
                        ;; (setq ispell-look-p nil)
                        ;; (setq company-ispell-dictionary (file-truename "~/.english-words.txt"))
                        ;; (set (make-local-variable 'company-backends)
                        ;;      '((
                        ;;         company-ispell
                        ;;         )))
                        )) t)

  (defun org-insert-heading-then-insert() (interactive)(beginning-of-line)(org-insert-heading)(evil-insert-state))
  (defun org-insert-heading-after-then-insert() (interactive)(end-of-line)(org-insert-heading)(evil-insert-state))
  ;; (evil-define-key 'insert evil-org-mode-map
  ;;   (kbd "RET") 'org-meta-return
  ;;   )
  (evil-define-key 'visual evil-org-mode-map
    "<" 'org-metaleft
    ">" 'org-metaright
    )
  ) ;; end my-org-setup

(with-eval-after-load 'org
  (my-org-setup)
  )

(global-set-key (kbd "C-0") (lambda() (interactive)(find-file "~/Dropbox/org/todo.org")))
;; (global-set-key (kbd "C-9") (lambda() (interactive)(find-file "~/Dropbox/org/todo.org")))
