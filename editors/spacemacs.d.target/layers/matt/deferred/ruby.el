(setq ruby-insert-encoding-magic-comment nil)

(spacemacs|diminish rubocop-mode)

(add-to-list 'auto-mode-alist '("\\pryrc\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\Berksfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\Vagrantfile.*\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\spatula\\'" . ruby-mode))

(evil-leader/set-key-for-mode 'ruby-mode "e" 'xmpfilter)
(evil-leader/set-key-for-mode 'ruby-mode "=" 'ruby-beautify-region-or-buffer)
(evil-leader/set-key-for-mode 'ruby-mode "xx" 'ruby-autocorrect-file)

(defun my-ruby-mode-hook ()
  (message "running ruby-mode-hook")
  ;; http://stackoverflow.com/questions/8473131/set-the-evil-shift-width-to-the-buffer-local-indentation-in-emacs
  (setq evil-shift-width ruby-indent-level)
  (setq flycheck-disabled-checkers '(
                                     ruby-reek
                                     ruby-rubocop
                                     chef-foodcritic
                                     ))
  (setq company-dabbrev-code-other-buffers 'all)
  (make-local-variable 'company-backends)
  (setq company-backends '((
                            company-etags
                            company-dabbrev
                            company-dabbrev-code
                            company-yasnippet
                            company-keywords
                            )))
  ;; (modify-syntax-entry ?_ "w" ruby-mode-syntax-table)
  ;; (modify-syntax-entry ?: "." ruby-mode-syntax-table)
  )
(add-hook 'ruby-mode-hook 'my-ruby-mode-hook)
