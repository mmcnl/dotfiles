;; https://github.com/syl20bnr/spacemacs/issues/2943
(setq neo-vc-integration nil)

(setq-default neo-window-width 30)
(setq-default neo-show-hidden-files t)

(require 'neotree)
(require 'projectile)

(add-to-list 'neo-hidden-regexp-list "\\TAGS$")

(defun neotree-find-maybe-in-project ()
  (interactive)
  (if (projectile-project-p)
      ;; then
      (progn
        (neotree-hide)
        (neotree-find-project-root)
        )
    ;; else
    (neotree-find)
    )
  )

(defun custom-neotree-enter-hide ()
  (interactive)
  (neotree-enter)
  (neotree-hide)
  )

(defun custom-neotree-enter-vertical-split-hide ()
  (interactive)
  (neotree-enter-vertical-split)
  (neotree-hide)
  )

(defun custom-neotree-enter-horizontal-split-hide ()
  (interactive)
  (neotree-enter-horizontal-split)
  (neotree-hide)
  )

(defun custom-neotree-peek ()
  (interactive)
  (neotree-enter)
  (select-window-0)
  )

(evilified-state-evilify neotree-mode neotree-mode-map
  (kbd "-") 'custom-neotree-enter-horizontal-split-hide
  (kbd "|") 'custom-neotree-enter-vertical-split-hide
  (kbd "RET") 'custom-neotree-enter-hide
  (kbd "TAB") 'custom-neotree-peek)

(with-eval-after-load 'neotree
  (custom-set-faces
   (set-face-attribute 'neo-button-face      nil :height 0.85)
   (set-face-attribute 'neo-file-link-face   nil :height 0.85)
   (set-face-attribute 'neo-dir-link-face    nil :foreground "#888" :height 0.85)
   (set-face-attribute 'neo-header-face      nil :height 0.85)
   (set-face-attribute 'neo-expand-btn-face  nil :height 0.85)
   )
  )
