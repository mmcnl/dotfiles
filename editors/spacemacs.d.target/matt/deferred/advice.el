(defadvice simpleclip-copy (after clear-mark activate)
  "clear mark"
  (message "copied to clipboard")
  (evil-escape)
  )

(defadvice eval-region (after quit-after activate)
  "evaluate region"
  (deactivate-mark)
  )

(defadvice spacemacs/python-execute-file (before save-buffer activate)
  "Save buffer first."
  (save-buffer)
  )

(defadvice ein:pager--open-with-text (after scale-text activate)
  "Scale text"
  (text-scale-set -1)
  (visual-line-mode)
  )
