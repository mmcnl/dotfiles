(defun sync-to-pod ()
  (when (string-match-p "petabox" (buffer-file-name))
    (shell-command-to-string
     (format "/Users/matt/dev/ia/kre8/branch-sync-edit.sh -rlptzv --progress --exclude=.git --exclude=.vscode %s %s" buffer-file-name buffer-file-name)
     )
    )
  )

(add-hook 'after-save-hook 'sync-to-pod)
