(defun matt-load-deferred-config-files ()
  (message "loading config files from matt layer...")
  ;; load these after all other spacemacs layers have loaded
  (mapc 'load (file-expand-wildcards "~/.spacemacs.d/matt/deferred/*.el"))
  ;; remove compile window
  )
