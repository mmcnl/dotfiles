(with-eval-after-load 'flycheck
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  ;; disable json-jsonlist checking for json files
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(json-jsonlist)))
  ;; disable jshint since we prefer eslint checking
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(javascript-jshint))))

(setq web-mode-content-types-alist
      '(("jsx" . "\\.js[x]?\\'")))
(setq web-mode-enable-engine-detection t)

(setq-default js2-basic-offset 2)
(setq-default js2-mode-show-parse-errors nil)
(setq-default js2-mode-show-strict-warnings nil)

;; http://www.emacswiki.org/emacs-en/download/misc-cmds.el
(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive)
  (save-buffer)
  (remove-hook 'find-file-hook 'undohist-recover-safe)
  (revert-buffer :ignore-auto :noconfirm)
  (add-hook 'find-file-hook 'undohist-recover-safe)
  )

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

(spacemacs/set-leader-keys-for-major-mode 'web-mode
  "xx" 'eslint-fix-file-and-revert )
