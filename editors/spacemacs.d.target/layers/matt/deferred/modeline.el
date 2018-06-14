(defun matt-setup-modeline ()
  (setq powerline-default-separator nil)
  ;; disable some default segments
  (spaceline-toggle-workspace-number-off)
  (spaceline-toggle-buffer-position-off)
  (spaceline-toggle-hud-off)
  (spaceline-toggle-buffer-encoding-abbrev-off)
  (spaceline-toggle-purpose-off)

  ;; add optional time display
  (setq display-time-load-average-threshold 4.0)
  (setq display-time-format "%l:%M")
  (spacemacs|add-toggle display-time-mode
    :status (symbol-value display-time-mode)
    :on (display-time-mode t)
    :off (display-time-mode -1)
    :documentation "Toggle time display in modeline"
    :evil-leader "tmT")
  (display-time-mode 1)

  (defun buffer-and-one-dir (dir)
    (string-match "\\([^/]+/[^/]+$\\)" dir)
    (match-string 1 dir))

  (spaceline-define-segment buffer-id
    "Name of buffer including one directory"
    (concat "   " (if (buffer-file-name) (buffer-and-one-dir (buffer-file-name)) (buffer-name) ) "   ")
    )

  ;; extracted from http://stackoverflow.com/a/8191130
  (defvar modeline-buffer-line-count "")
  (make-variable-buffer-local 'modeline-buffer-line-count)
  (defun update-line-count-for-modeline ()
    (setq modeline-buffer-line-count (concat "/" (int-to-string (count-lines (point-min) (point-max))))))
  (add-hook 'find-file-hook 'update-line-count-for-modeline)
  (add-hook 'after-save-hook 'update-line-count-for-modeline)
  (add-hook 'after-revert-hook 'update-line-count-for-modeline)
  (add-hook 'dired-after-readin-hook 'update-line-count-for-modeline)
  ;; add line count of buffer to default segment
  (spaceline-define-segment line-column
    "current_column  current_line/total_lines"
    (concat "%2c %4l" modeline-buffer-line-count)
    )

  ;; don't show "Git" and only show branch if not master
  (defadvice vc-mode-line (after strip-backend () activate)
    (when (stringp vc-mode)
      (let ((gitlogo (replace-regexp-in-string "^ Git." " " vc-mode)))
        (setq vc-mode (replace-regexp-in-string " master" "" gitlogo)))))

  ;; prevent the Helm title from being highlighted
  (defface my-spaceline-highlight-face
    `((t (:inherit 'font-lock-comment-face :italic nil)))
    "Default highlight face for spaceline."
    :group 'spaceline)

  (defun set-my-spaceline-highlight-face ()
    "Custom highlight face function."
    'my-spaceline-highlight-face)

  (setq spaceline-highlight-face-func 'set-my-spaceline-highlight-face)

  (setq spaceline-byte-compile t)
  (spaceline-compile)
  ;; see also themes.el for more spaceline customizations
  )
