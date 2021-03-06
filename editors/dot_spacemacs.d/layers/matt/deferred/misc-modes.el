(spacemacs|diminish which-key-mode)
(spacemacs|diminish hi-lock-mode)
(spacemacs|diminish smartparens-mode)
(spacemacs|diminish dired-omit-mode)
(spacemacs|diminish yas-minor-mode)

(require 'lsp-mode)
(setq lsp-enable-file-watchers nil)

(add-hook 'live-py-mode-hook (lambda ()
                               (progn
                                 (setq-default live-py-version (executable-find "python3"))
                                 (live-py-update-all))))


(defun prog-mode-common-setup ()
  (flycheck-mode 1)
  (flyspell-mode-off)
  (display-line-numbers-mode t)
  (whitespace-mode)
  (yafolding-mode)
  (setq whitespace-style '(
                           face
                           indentation
                           space-after-tab
                           space-before-tab
                           tab-mark
                           tabs
                           trailing
                           ))
  (company-mode 1)
  )

(add-hook 'php-mode-hook #'(lambda()
                             (setq php-mode-coding-style 'psr-2)
                             (setq c-basic-offset 2)))

(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))

(add-hook 'prog-mode-hook 'prog-mode-common-setup)

(add-hook 'css-mode-hook
          (function (lambda ()
                      ;; prevent . and # from being included when searching project by symbol
                      (modify-syntax-entry ?. "." css-mode-syntax-table)
                      (modify-syntax-entry ?# "." css-mode-syntax-table)
                      )) t)

(add-hook 'help-mode-hook
          (function (lambda ()
                      (text-scale-set -1)
                      (visual-line-mode)
                      )) t)

(add-hook 'python-mode-hook
          (function (lambda ()
                      ;; https://stackoverflow.com/a/51966682
                      (setq-default python-indent-offset 4)
                      (setq python-indent-guess-indent-offset t)
                      (setq lsp-pyls-plugins-jedi-use-pyenv-environment t)
                      (setq python-indent-guess-indent-offset-verbose nil)

                      (setq-default python-shell-interpreter "python")
                      (setq python-shell-interpreter-args "")
                      (lsp-ui-doc-mode -1)
                      ;; (setq-default python-shell-interpreter "/usr/local/opt/python@3.9/bin/python3")
                      ;; (setq-default python-shell-interpreter "ipython")
                      ;; (setq python-shell-interpreter-args "--simple-prompt -i")
                      )) t)

(add-hook 'inferior-python-mode-hook
          (function (lambda ()
                      (text-scale-set -1)
                      (visual-line-mode)
                      )) t)

(add-hook 'diff-mode-hook
          (function (lambda ()
                      (evilified-state-evilify diff-mode diff-mode-map
                        "q" 'kill-buffer-and-window
                        )
                      (whitespace-mode -1)
                      (evil-window-move-far-right)
                      (diff-ignore-whitespace-hunk)
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

(add-hook 'python-mode-hook
          (function (lambda ()
                      (yapf-mode)
                      )) t)

(add-hook 'yaml-mode-hook
          (function (lambda ()
                      (prog-mode-common-setup)
                      )) t)

;; (require 'flycheck-yamllint)
;; (eval-after-load 'flycheck
;;   '(add-hook 'flycheck-mode-hook 'flycheck-yamllint-setup))

(add-hook 'emacs-lisp-mode-hook
          (function (lambda ()
                      ;; (aggressive-indent-mode 1) ;; seems to be freezing emacs 6/14/18
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
