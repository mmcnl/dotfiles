(defadvice simpleclip-copy (after clear-mark activate)
  "clear mark"
  (message "copied to clipboard")
  (evil-escape)
  )

(defadvice eval-region (after quit-after activate)
  "evaluate region"
  (deactivate-mark)
  )

(defadvice rubocop-autocorrect-current-file (before save-correcting activate)
  "Save buffer first."
  (save-buffer)
  )
