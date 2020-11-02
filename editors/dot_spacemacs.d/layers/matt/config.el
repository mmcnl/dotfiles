(defun matt-load-deferred-config-files ()
  (message "loading config files from matt layer...")

  ;; load these after all other spacemacs layers have loaded
  (mapc 'load (file-expand-wildcards "~/.spacemacs.d/layers/matt/deferred/*.el"))

  (setq dired-listing-switches
        "-AGFhlv --group-directories-first --time-style=long-iso")

  (server-start)
  (matt-customize-themes) ;; apply initial theme fixes

  (spacemacs/toggle-maximize-frame-on)
  (delete-other-windows)

  (defun matt-finish-loading-config ()
    (matt-setup-modeline)
    (message "")

    ;; placed at end of config loading to ensure override of spacemacs function
    (defun spacemacs/helm-files-do-rg (&optional dir)
      "Search in files with `rg'."
      (interactive)
      ;; --line-number forces line numbers (disabled by default on windows)
      ;; no --vimgrep because it adds column numbers that wgrep can't handle
      ;; see https://github.com/syl20bnr/spacemacs/pull/8065
      (let* ((root-helm-ag-base-command "rg --smart-case --max-filesize 1M --max-columns 200 --no-heading --color never --line-number")
             (helm-ag-base-command root-helm-ag-base-command)
)
        (helm-do-ag dir)))
    )
  ;; for unknown reasons, modeline setup needs to be delayed
  (run-at-time "2 sec" nil #'matt-finish-loading-config)
  )
