(with-eval-after-load 'flycheck

  ;; disable json-jsonlist checking for json files
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(json-jsonlist)))

  ;; disable jshint since we prefer eslint checking
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(javascript-jshint)))

  (setq-default js2-mode-show-parse-errors nil)
  (setq-default js2-mode-show-strict-warnings nil)

  ;; http://www.emacswiki.org/emacs-en/download/misc-cmds.el
  (defun revert-buffer-no-confirm ()
    "Revert buffer without confirmation."
    (interactive)
    (setq buffer-undo-tree nil)
    (revert-buffer :ignore-auto :noconfirm))

  (defun eslint-fix-file ()
    (interactive)
    (message "eslint --fixing " (buffer-file-name))
    (shell-command (concat "eslint --fix " (buffer-file-name))))

  ;; https://gist.github.com/ustun/73321bfcb01a8657e5b8
  (defun eslint-fix-file-and-revert ()
    (interactive)
    (save-buffer)
    (eslint-fix-file)
    (revert-buffer-no-confirm))

  (spacemacs/set-leader-keys-for-major-mode 'json-mode
    "xx" 'json-pretty-print-buffer )

  (spacemacs/set-leader-keys-for-major-mode 'js2-mode
    "xx" 'eslint-fix-file-and-revert )

  )
