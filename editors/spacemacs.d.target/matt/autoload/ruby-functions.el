(defadvice avy-goto-word-or-subword-1 (before update-syntax-before activate)
  "treat underscores as punctuation"
  (when (derived-mode-p 'ruby-mode)
    (modify-syntax-entry ?_ "." ruby-mode-syntax-table)
    )
  )
(defadvice avy-goto-word-or-subword-1 (after update-syntax-after activate)
  "treat underscores as parts of words"
  )

(defun ruby-autocorrect-file ()
  "Tidy ruby file"
  (interactive)
  (save-buffer)
  (spacemacs/indent-region-or-buffer)
  (rubocop-autocorrect-current-file)
  )

(defun xmpfilter ()
  "Replace the current region (or the whole buffer, if none) with the output
of xmpfilter"
  (interactive)
  (let ((beg (if (region-active-p) (region-beginning) (point-min)))
        (end (if (region-active-p) (region-end) (point-max))))
    (shell-command-on-region beg end "xmpfilter" nil 'replace)))

(defun ruby-beautify-region-or-buffer ()
  "Replace the current region (or the whole buffer, if none) with the output
of ruby-beautify"
  (interactive)
  (let ((beg (if (region-active-p) (region-beginning) (point-min)))
        (end (if (region-active-p) (region-end) (point-max))))
    (shell-command-on-region beg end "ruby-beautify" nil 'replace)))
