;; disabled as it seems to be causing corruption
;; (setq undo-tree-auto-save-history t
;;       undo-limit        1000000
;;       undo-strong-limit 1000000
;;       undo-outer-limit 20000000
;;       undo-tree-history-directory-alist (quote (("." . "~/.emacs.d/undo/")))
;;       )
(use-package undohist
  :init
  (setq undohist-directory (expand-file-name "undo-history" spacemacs-cache-directory))
  :config
  (undohist-initialize))

(defadvice undo-tree-visualize (around undo-tree-split-side-by-side activate)
  "Split undo-tree side-by-side"
  (let ((golden-ratio-mode -1)
        (split-height-threshold nil)
        (split-width-threshold 0))
    ad-do-it))

(spacemacs/remove-popwin-display-config " *undo-tree*")
