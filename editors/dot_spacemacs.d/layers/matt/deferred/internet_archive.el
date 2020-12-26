(defun sync-to-pod ()
  (when (string-match-p "petabox" (buffer-file-name))
    (message "syncing %s to petabox" buffer-file-name)
    (shell-command-to-string
     (format "/Users/matt/dev/ia/nomad/vsync -rlptzv --progress --exclude=.git --exclude=.vscode %s %s" buffer-file-name buffer-file-name)
     )
    )
  )
(add-hook 'after-save-hook 'sync-to-pod)

(require 'browse-at-remote)
(add-to-list 'browse-at-remote-remote-type-domains '("git.archive.org" . "gitlab"))
