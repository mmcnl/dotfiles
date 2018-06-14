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
    (message "Done")
    )
  ;; for unknown reasons, modeline setup needs to be delayed
  (run-at-time "2 sec" nil #'matt-finish-loading-config)
  )
