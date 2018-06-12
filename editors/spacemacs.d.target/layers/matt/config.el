(defun matt-load-deferred-config-files ()
  (message "loading config files from matt layer...")

  ;; load these after all other spacemacs layers have loaded
  (mapc 'load (file-expand-wildcards "~/.spacemacs.d/layers/matt/deferred/*.el"))

  (spacemacs/toggle-maximize-frame-on)
  (server-start)
  (matt-customize-themes) ;; apply initial theme fixes
  )
