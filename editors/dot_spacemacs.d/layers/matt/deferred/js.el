(with-eval-after-load 'flycheck
  (flycheck-add-mode 'javascript-eslint 'rjsx-mode)
  ;; (flycheck-add-mode 'javascript-eslint 'web-mode)
  ;; disable json-jsonlist checking for json files
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(json-jsonlist)))
  ;; disable jshint since we prefer eslint checking
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(javascript-jshint))))

(defun react-tag-fix ()
  (define-key evil-insert-state-local-map (kbd "C-d") 'rjsx-delete-creates-full-tag))

(add-hook 'rjsx-mode-hook 'react-tag-fix)

;; (setq web-mode-content-types-alist
;;       '(("jsx" . "\\.js[x]?\\'")))
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

(spacemacs/set-leader-keys-for-major-mode 'js2-mode
  "xx" 'eslint-fix-file-and-revert )

(spacemacs/set-leader-keys-for-major-mode 'rjsx-mode
  "xx" 'eslint-fix-file-and-revert )

(add-to-list 'auto-mode-alist '("\\.jsx\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.react.js\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\index.android.js\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\index.ios.js\\'" . rjsx-mode))
;; https://www.emacswiki.org/emacs/MagicModeAList#magic-mode-alist
(add-to-list 'magic-mode-alist '("/\\*\\* @jsx React\\.DOM \\*/" . rjsx-mode))
(add-to-list 'magic-mode-alist '("import\s+.*from\s+['\"]react['\"]" . rjsx-mode))

(add-hook 'rjsx-mode-hook
          (lambda ()
            (emmet-mode)
            ))
