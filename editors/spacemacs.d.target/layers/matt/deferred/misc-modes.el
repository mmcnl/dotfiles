(spacemacs|diminish which-key-mode)
(spacemacs|diminish hi-lock-mode)
(spacemacs|diminish smartparens-mode)
(spacemacs|diminish dired-omit-mode)
(spacemacs|diminish yas-minor-mode)

(defun prog-mode-common-setup ()
  (flycheck-mode 1)
  (flyspell-mode-off)
  (linum-mode)
  ;; (linum-relative-on)
  (company-mode 1)
  )

(add-hook 'prog-mode-hook 'prog-mode-common-setup)

(add-hook 'help-mode-hook
          (function (lambda ()
                      (text-scale-set -1)
                      (visual-line-mode)
                      )) t)

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
                      ;; (flyspell-mode)

                      ;; needed to enable completion in git commit buffer
                      (company-mode)

                      (set (make-local-variable 'company-backends)
                           '((
                              company-dabbrev
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

(add-hook 'emmet-mode-hook (lambda () (define-key emmet-mode-keymap (kbd "C-j") 'electric-newline-and-maybe-indent)))

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd ":") 'helm-M-x)
  (define-key dired-mode-map (kbd "C-c C-e") (lambda() (interactive)(wdired-change-to-wdired-mode)(evil-normal-state)(forward-char)))
  ;; don't spawn a new buffer every entering a directory
  ;; (define-key dired-mode-map [return] 'find-alternate-file)
  ;; let "-" go up a directory level
  (define-key dired-mode-map "-"
    (function
     (lambda nil (interactive) (find-alternate-file ".."))))
  )
