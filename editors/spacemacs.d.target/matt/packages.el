(defvar matt-packages
  '(
    simpleclip
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar matt-excluded-packages '()
  "List of packages to exclude.")

(defun matt/init-simpleclip ()
  "Initialize simpleclip"
  (use-package simpleclip
    :config
    (simpleclip-mode t))
  )
