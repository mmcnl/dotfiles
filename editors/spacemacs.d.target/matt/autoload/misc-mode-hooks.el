(defun prog-mode-common-setup ()
  (flycheck-mode 1)
  (flyspell-mode-off)
  (linum-mode)
  (linum-relative-on)
  )

(add-hook 'prog-mode-hook 'prog-mode-common-setup)

(add-hook 'diff-mode-hook
          (function (lambda ()
                      (whitespace-mode -1)
                      )) t)

(add-hook 'sh-mode-hook
          (lambda ()
            ;; allow sh-shellcheck to lint files (it's not compatible with zsh)
            (sh-set-shell "bash")))

(add-hook 'text-mode-hook
          (function (lambda ()
                      (visual-line-mode 1)
                      (flyspell-mode)

                      ;; needed to enable completion in git commit buffer
                      (company-mode)

                      (set (make-local-variable 'company-backends)
                           '((
                              company-dabbrev
                              company-ispell
                              )))
                      )) t)

(add-hook 'yaml-mode-hook
          (function (lambda ()
                      (prog-mode-common-setup)
                      )) t)

(add-hook 'emacs-lisp-mode-hook
          (function (lambda ()
                      (aggressive-indent-mode 1)
                      (flycheck-mode -1)
                      (setq flycheck-disabled-checkers '(
                                                         emacs-lisp-checkdoc
                                                         ))
                      )) t)

(add-hook 'web-mode-hook
          (function (lambda ()
                      (setq web-mode-markup-indent-offset 2)
                      (setq web-mode-css-indent-offset 2)
                      (setq web-mode-code-indent-offset 2)
                      )) t)


(setq ein:notebook-kill-buffer-ask nil)
;; Start completion when inserting a dot.
(setq ein:complete-on-dot t)
(setq ein:use-auto-complete-superpack t)

(add-hook 'ein:connect-mode-hook 'ein:jedi-setup)
(add-hook 'ein:notebook-multilang-mode-hook
          (function (lambda ()
                      (visual-line-mode)
                      (auto-complete-mode)
                      (define-key ac-completing-map (kbd "C-l") 'ac-expand)
                      )) t)
