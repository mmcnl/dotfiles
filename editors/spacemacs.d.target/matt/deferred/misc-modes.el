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

(add-to-list 'auto-mode-alist '("\\.jst.str\\'" . web-mode))

(add-to-list 'auto-mode-alist '("\\.jin\\'" . web-mode))

(add-hook 'emmet-mode-hook (lambda () (define-key emmet-mode-keymap (kbd "C-j") 'electric-newline-and-maybe-indent)))

(add-hook 'web-mode-hook
          (function (lambda ()
                      (setq web-mode-markup-indent-offset 2)
                      (setq web-mode-css-indent-offset 2)
                      (setq web-mode-code-indent-offset 2)
                      (setq web-mode-enable-engine-detection t)
                      (setq web-mode-engines-alist
                            '(("jinja"    . "\\.jin\\'")
                              ("blade"  . "\\.blade\\."))
                            )
                      (set (make-local-variable
                            'company-backends) '((
                                                  company-web-html
                                                  company-css
                                                  company-dabbrev
                                                  )))
                      )) t)

(setq ein:notebook-enable-undo 'full)
(setq ein:notebook-kill-buffer-ask nil)
;; Start completion when inserting a dot.
(setq ein:complete-on-dot t)
(setq ein:use-auto-complete-superpack t)
;; (run-with-timer 0 (* 30 60) 'ein:notebook-save-notebook-command)
(defun save-ein-notebook()
  (when (eq major-mode 'ein:notebook-multilang-mode)
    (ein:notebook-save-notebook-command)))

(run-with-idle-timer 20 t 'save-ein-notebook)
(add-hook 'ein:connect-mode-hook 'ein:jedi-setup)
(add-hook 'ein:notebook-multilang-mode-hook
          (function (lambda ()
                      (auto-complete-mode)
                      (define-key ac-completing-map (kbd "C-l") 'ac-expand)
                      )) t)
(spacemacs/set-leader-keys-for-major-mode 'ein:notebook-multilang-mode
  "s" 'ein:console-open )
(spacemacs/set-leader-keys-for-major-mode 'ein:notebook-multilang-mode
  "a" 'ein:pytools-request-help )
(spacemacs/set-leader-keys-for-major-mode 'ein:notebook-multilang-mode
  (kbd "CS-l") 'ein:pytools-request-help )
(spacemacs/set-leader-keys-for-major-mode 'ein:notebook-multilang-mode
  "Fj" 'ein:notebook-scratchsheet-open )

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd ":") 'helm-M-x)
  ;; don't spawn a new buffer every entering a directory
  (define-key dired-mode-map [return] 'dired-single-buffer)
  ;; let "-" go up a directory level
  (define-key dired-mode-map "-"
    (function
     (lambda nil (interactive) (dired-single-buffer ".."))))
  )

(spacemacs/set-leader-keys-for-major-mode 'json-mode
  "xx" 'json-pretty-print-buffer )

