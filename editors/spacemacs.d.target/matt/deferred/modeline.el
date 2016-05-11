(with-eval-after-load 'spaceline
  ;; https://github.com/TheBB/spaceline#powerline-separators
  (setq powerline-default-separator 'bar)

  ;; disable some default segments
  (spaceline-toggle-workspace-number-off)
  (spaceline-toggle-buffer-position-off)
  (spaceline-toggle-buffer-encoding-abbrev-off)

  ;; add optional time display
  (setq display-time-load-average-threshold 4.0)
  (setq display-time-format "%l:%M%p")
  (spacemacs|add-toggle display-time-mode
    :status (symbol-value display-time-mode)
    :on (display-time-mode t)
    :off (display-time-mode -1)
    :documentation "Toggle time display in modeline"
    :evil-leader "tmT")

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
    (concat "%2c %4l" modeline-buffer-line-count))

  ;; don't show "Git" and only show branch if not master
  (defadvice vc-mode-line (after strip-backend () activate)
    (when (stringp vc-mode)
      (let ((gitlogo (replace-regexp-in-string "^ Git." " " vc-mode)))
        (setq vc-mode (replace-regexp-in-string " master" "" gitlogo)))))

  (spaceline-define-segment version-control
    "Version control information."
    (powerline-raw
     (s-trim (concat vc-mode
                     (when (buffer-file-name)
                       (pcase (vc-state (buffer-file-name))
                         (`up-to-date " ")
                         (`edited " ⋆")
                         (`added " ⊕")
                         (`unregistered " ??")
                         (`removed " Del")
                         (`needs-merge " ⊗")
                         (`needs-update " Upd")
                         (`ignored " ⊘")
                         (_ " Unk"))))))
    :when vc-mode)

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
  )
;; see also themes.el for more spaceline customizations
