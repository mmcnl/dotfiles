(setq helm-ff-skip-boring-files t)
(setq helm-boring-file-regexp-list
      '("\\.git$" "\\.hg$" "\\.svn$" "TAGS$" "\\._darcs$" "\\.la$" "\\.o$" "undo-tree" "~$"
        "\\.so$" "\\.a$" "\\.elc$" "\\.fas$" "\\.fasl$" "\\.pyc$" "\\.pyo$" "\\.min.js$"))

(setq helm-boring-buffer-regexp-list
      (quote
       (  "\\Minibuf.+\\*"
          "\\.min.js$"
          "\\` "
          "TAGS$"
          "\\*[Hh]elm.*\\*"
          )))

;; https://github.com/syohex/emacs-helm-ag#helm-ag-ignore-buffer-patternsdefault-nil
(setq-default helm-ag-ignore-buffer-patterns helm-boring-buffer-regexp-list)

(setq helm-autoresize-min-height 40
      helm-autoresize-max-height 60
      recentf-max-saved-items 500
      helm-ff-candidate-number-limit 300
      )

(with-eval-after-load 'helm
  ;; https://github.com/tonsky/FiraCode/wiki/Emacs-instructions
  (add-hook 'helm-major-mode-hook
            (lambda ()
              (setq auto-composition-mode nil)))

  (helm-autoresize-mode 1)
  (define-key helm-map (kbd "C-w") 'backward-delete-word)
  (define-key helm-map (kbd "C-h") 'backward-delete-char)
  (define-key helm-map (kbd "C-d") 'helm-next-page)
  (define-key helm-map (kbd "C-u") 'helm-previous-page)

  ;; https://github.com/emacs-helm/helm/issues/1892
  (require 'helm-for-files)

  )

;; override spacemacs mapping for C-h to navigate up one level
(with-eval-after-load 'helm-files
  (dolist (keymap (list helm-find-files-map helm-read-file-map))
    (define-key keymap (kbd "C-h") 'backward-delete-char)
    ))
