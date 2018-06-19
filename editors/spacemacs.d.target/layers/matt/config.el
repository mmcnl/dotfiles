(defun matt-load-deferred-config-files ()
  (message "loading config files from matt layer...")

  ;; load these after all other spacemacs layers have loaded
  (mapc 'load (file-expand-wildcards "~/.spacemacs.d/layers/matt/deferred/*.el"))

  (server-start)
  (matt-customize-themes) ;; apply initial theme fixes
  (spacemacs/toggle-maximize-frame-on)
  (delete-other-windows)

  (defun matt-finish-loading-config ()
    (matt-setup-modeline)
    (message "")

    ;; allow for custom list of files to always ignore with rg (eg *.min.js)
    ;; placed at end of config loading to ensure override of spacemacs function
    (defun spacemacs/helm-files-do-rg (&optional dir)
      "Search in files with `rg'."
      (interactive)
      ;; --line-number forces line numbers (disabled by default on windows)
      ;; no --vimgrep because it adds column numbers that wgrep can't handle
      ;; see https://github.com/syl20bnr/spacemacs/pull/8065
      (let* ((root-helm-ag-base-command "rg --smart-case --no-heading --color never --line-number --glob !*min.js")
             (helm-ag-base-command (if spacemacs-helm-rg-max-column-number
                                       (concat root-helm-ag-base-command " --max-columns " (number-to-string spacemacs-helm-rg-max-column-number))
                                     root-helm-ag-base-command)))
        (helm-do-ag dir)))
    )
  ;; for unknown reasons, modeline setup needs to be delayed
  (run-at-time "2 sec" nil #'matt-finish-loading-config)
  )
