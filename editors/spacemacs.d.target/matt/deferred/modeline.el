(with-eval-after-load 'spaceline
  ;; https://github.com/TheBB/spaceline#powerline-separators
  (setq powerline-default-separator 'bar)
  (spaceline-compile)

  (setq spaceline-evil-state-p t)
  (setq spaceline-workspace-number-p nil)
  (setq spaceline-window-number-p t)
  (setq spaceline-minor-modes-p t)
  (setq spaceline-buffer-size-p t)
  (setq spaceline-buffer-position-p nil)
  (setq spaceline-version-control-p t)
  (setq spaceline-buffer-encoding-abbrev-p t)
  (setq spaceline-hud-p nil)

  (setq display-time-load-average-threshold 3.0)
  (setq display-time-format "%l:%M%p")

  (spacemacs|add-toggle display-time-mode
    :status (symbol-value display-time-mode)
    :on (display-time-mode t)
    :off (display-time-mode -1)
    :documentation "Toggle time display in modeline"
    :evil-leader "tmT")

  ;; extracted from http://stackoverflow.com/a/8191130
  (defvar my-mode-line-buffer-line-count "")
  (make-variable-buffer-local 'my-mode-line-buffer-line-count)

  (defun my-mode-line-count-lines ()
    (setq my-mode-line-buffer-line-count (concat "/" (int-to-string (count-lines (point-min) (point-max))))))

  (add-hook 'find-file-hook 'my-mode-line-count-lines)
  (add-hook 'after-save-hook 'my-mode-line-count-lines)
  (add-hook 'after-revert-hook 'my-mode-line-count-lines)
  ;; (add-hook 'dired-after-readin-hook 'my-mode-line-count-lines)

  (spaceline-define-segment line-column
    "The current line and column numbers."
    (concat "%2c %4l" my-mode-line-buffer-line-count))

  ;; strip the <> from the Evil state at left edge of modeline
  ;; (spaceline-define-segment evil-state
  ;;   "The current evil state.  Requires `evil-mode' to be enabled."
  ;;   (replace-regexp-in-string "[<>]" "" (s-trim (evil-state-property evil-state :tag t)))
  ;;   :when (bound-and-true-p evil-local-mode))

  ;; prevent the Helm title from being highlighted
  (defface my-spaceline-highlight-face
    `((t (:inherit 'font-lock-comment-face :italic nil)))
    "Default highlight face for spaceline."
    :group 'spaceline)

  (defun set-my-spaceline-highlight-face ()
    "Custom highlight face function."
    'my-spaceline-highlight-face)

  (setq spaceline-highlight-face-func 'set-my-spaceline-highlight-face)
  )
;; see also themes.el for more spaceline customizations
