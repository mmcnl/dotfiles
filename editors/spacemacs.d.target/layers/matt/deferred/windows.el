;; prefer "vertical" splits for other buffers
;; +-------+--------+
;; |       |        |
;; +-------+--------+
(setq-default helm-window-prefer-horizontal-split t)
(setq-default helm-split-window-default-side 'right)
(setq-default split-height-threshold nil)
(setq-default split-width-threshold 0)

;; https://twitter.com/iLemming/status/973932170354950145
(dolist (buf (list " *Minibuf-0*" " *Minibuf-1*" " *Echo Area 0*" " *Echo Area 1*"))
  (when (get-buffer buf)
    (with-current-buffer buf
      (setq-local face-remapping-alist '((default (:height 0.8)))))))

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
  "ws" 'split-window-below-and-focus
  "wv" 'split-window-right-and-focus
  )

;; https://github.com/syl20bnr/spacemacs/issues/7409#issuecomment-254118250
;; (setq persp-auto-save-opt 0)

;; fixes https://github.com/syl20bnr/spacemacs/issues/7446#issuecomment-417302881
(defun spacemacs/display-neotree (buffer _alist)
  "Display BUFFER to the left or right of the main window.
Doesn't give the new window real side window parameters, so
technically it is not a side window.

_ALIST is ignored."
  (let ((side (if (eq neo-window-position 'left) 'left 'right))
        (main-window (if (version< emacs-version "26")
                         (window--major-non-side-window)
                       (window-main-window))))

    ;; don't set width or dedicate buffer, even though we could, because
    ;; neotree will do that later
    (window--display-buffer buffer
                            (split-window main-window nil side)
                            'window)))

(setq neo-display-action '(spacemacs/display-neotree))
