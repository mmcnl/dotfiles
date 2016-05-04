;; prefer vertical splits for opening files from helm
;; http://stackoverflow.com/a/7998271
(setq split-height-threshold nil)
(setq split-width-threshold 0)

(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

(setq which-key-popup-type 'minibuffer)
(setq which-key-allow-evil-operators nil)
(setq which-key-side-window-max-width 100)

(evil-leader/set-key
  "wS" 'split-window-below
  "wV" 'split-window-right
  "wo" 'delete-other-windows
  "ws" 'split-window-below-and-focus
  "wv" 'split-window-right-and-focus
  )

(global-set-key [(super n)] 'new-tmp-buffer)

(global-set-key [(super w)] (lambda () (interactive) (delete-frame)))
