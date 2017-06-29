;; prefer vertical splits for opening files
;; http://stackoverflow.com/a/7998271
(setq split-height-threshold nil)
(setq split-width-threshold 0)

(with-eval-after-load 'popwin
  (popwin-mode 1)
  (push '("*Flycheck errors*" :dedicated t :position bottom :stick
          t :noselect t :height 0.1) popwin:special-display-config)
  (push '("*compilation*" :dedicated t :position right :stick
          t :noselect t :width 0.4) popwin:special-display-config)
  )

(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

(setq which-key-allow-evil-operators nil)

(evil-leader/set-key
  "wS" 'split-window-below
  "wV" 'split-window-right
  "wo" 'delete-other-windows
  "ws" 'split-window-below-and-focus
  "wv" 'split-window-right-and-focus
  )

(global-set-key [(hyper n)] 'new-tmp-buffer)

(global-set-key [(hyper w)] (lambda () (interactive) (delete-frame)))

;; https://github.com/syl20bnr/spacemacs/issues/7409#issuecomment-254120878
(setq-default persp-auto-save-opt 0)
