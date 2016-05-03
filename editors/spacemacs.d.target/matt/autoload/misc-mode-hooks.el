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
                      ;; (setq flycheck-disabled-checkers '(
                      ;;                                    emacs-lisp-checkdoc
                      ;;                                    ))
                      )) t)
