(setq compilation-finish-function
      (lambda (buf str)
        (if (null (string-match ".*exited abnormally.*" str))
            (progn
              (message (buffer-string)
                       (delete-windows-on (current-buffer))
                       )))))

(defun ruby-autocorrect-file ()
  "Tidy ruby file"
  (interactive)
  (spacemacs/indent-region-or-buffer)
  (save-buffer)
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
