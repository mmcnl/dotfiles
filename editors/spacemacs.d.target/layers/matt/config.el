(defun matt-load-deferred-config-files ()
  (message "loading config files from matt layer...")

  ;; load these after all other spacemacs layers have loaded
  (mapc 'load (file-expand-wildcards "~/.spacemacs.d/layers/matt/deferred/*.el"))

  (server-start)
  (matt-customize-themes) ;; apply initial theme fixes
  (spacemacs/toggle-maximize-frame-on)
  (delete-other-windows)

  ;; for unknown reason, this needs to be delayed in order to fully function
  (run-at-time "5 sec" nil #'matt-setup-modeline)
  )
