(setq ruby-insert-encoding-magic-comment nil)

(defadvice avy-goto-word-or-subword-1 (before update-syntax-before activate)
  "treat underscores as punctuation"
  (when (derived-mode-p 'ruby-mode)
    (modify-syntax-entry ?_ "." ruby-mode-syntax-table)
    )
  )
(defadvice avy-goto-word-or-subword-1 (after update-syntax-after activate)
  "treat underscores as parts of words"
  )

(add-to-list 'auto-mode-alist '("\\pryrc\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\Berksfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\Vagrantfile.*\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\spatula\\'" . ruby-mode))

(add-hook 'ruby-mode-hook
          (function (lambda ()
                      (modify-syntax-entry ?_ "w" ruby-mode-syntax-table)
                      (modify-syntax-entry ?: "." ruby-mode-syntax-table)
                      ;; http://stackoverflow.com/questions/8473131/set-the-evil-shift-width-to-the-buffer-local-indentation-in-emacs
                      (setq evil-shift-width ruby-indent-level)
                      (setq flycheck-disabled-checkers '(
                                                         ruby-rubocop
                                                         chef-foodcritic
                                                         ))
                      (setq company-dabbrev-code-other-buffers 'all)
                      (make-local-variable 'company-backends)
                      (setq company-backends '(
                                               (
                                                company-etags
                                                company-dabbrev
                                                company-dabbrev-code
                                                company-yasnippet
                                                company-keywords
                                                )))
                      )) t)

(evil-leader/set-key-for-mode 'ruby-mode "e" 'xmpfilter)
(evil-leader/set-key-for-mode 'ruby-mode "B" 'ruby-beautify-region-or-buffer)
(evil-leader/set-key-for-mode 'ruby-mode "xx" 'ruby-autocorrect-file)

(spacemacs|diminish rubocop-mode "" " RuboCop")

(defun ruby-autocorrect-file ()
  "Tidy ruby file"
  (interactive)
  (save-buffer)
  (spacemacs/indent-region-or-buffer)
  (rubocop-autocorrect-current-file)
  )

(defun xmpfilter ()
  "Replace the current region (or the whole buffer, if none) with the output
of xmpfilter"
  (interactive)
  (let ((beg (if (region-active-p) (region-beginning) (point-min)))
        (end (if (region-active-p) (region-end) (point-max))))
    (shell-command-on-region beg end "xmpfilter" nil 'replace)))

(defun ruby-beautify-region-or-buffer ()
  "Replace the current region (or the whole buffer, if none) with the output
of ruby-beautify"
  (interactive)
  (let ((beg (if (region-active-p) (region-beginning) (point-min)))
        (end (if (region-active-p) (region-end) (point-max))))
    (shell-command-on-region beg end "ruby-beautify" nil 'replace)))
