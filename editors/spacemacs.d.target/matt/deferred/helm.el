(setq helm-ff-skip-boring-files t)
(setq helm-boring-file-regexp-list
      '("\\.git$" "\\.hg$" "\\.svn$" "TAGS$" "\\._darcs$" "\\.la$" "\\.o$" "undo-tree" "~$"
        "\\.so$" "\\.a$" "\\.elc$" "\\.fas$" "\\.fasl$" "\\.pyc$" "\\.pyo$"))

(setq helm-skip-boring-buffers t)
(setq helm-boring-buffer-regexp-list (quote ("TAGS$" "\#" "\\*[Hh]elm" "\\ \\*")))

(setq helm-autoresize-min-height 60
      helm-autoresize-max-height 60
      recentf-max-saved-items 500
      helm-ag-base-command "ag --hidden --nocolor --nogroup --smart-case"
      helm-ff-candidate-number-limit 300
      )

(with-eval-after-load 'helm
  (helm-autoresize-mode 1)
  (define-key helm-map (kbd "C-w") 'backward-delete-word)
  (define-key helm-map (kbd "C-h") 'backward-delete-char)
  (define-key helm-map (kbd "C-d") 'helm-next-page)
  (define-key helm-map (kbd "C-u") 'helm-previous-page)
  )

;; override spacemacs mapping for C-h to navigate up one level
(with-eval-after-load 'helm-files
  (dolist (keymap (list helm-find-files-map helm-read-file-map))
    (define-key keymap (kbd "C-h") 'backward-delete-char)
    ))
