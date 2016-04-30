(with-eval-after-load 'linum-relative
  (setq-default
   linum-relative-current-symbol "-"
   linum-format "%2s"
   linum-relative-format "%2s "
   linum-delay t)
  )

(setq hl-paren-colors '("SpringGreen3"
                        "DarkGreen"
                        "orange"
                        "blue"
                        "yellow"
                        "SkyBlue"
                        ))

(setq-default fringe-indicator-alist '((truncation . (right-arrow right-arrow right-arrow)) (continuation . right-curly-arrow)))

(defun matt-cycle-themes()
  (interactive)
  (spacemacs/cycle-spacemacs-theme)
  (matt-customize-themes)
  )

;; prevent the Helm title from being highlighted
(defface my-spaceline-highlight-face
  `((t (:inherit 'font-lock-comment-face :italic nil)))
  "Default highlight face for spaceline."
  :group 'spaceline)

(defun set-my-spaceline-highlight-face ()
  "Custom highlight face function."
  'my-spaceline-highlight-face)

(setq spaceline-highlight-face-func 'set-my-spaceline-highlight-face)

(defun matt-customize-themes()
  ;; mods common to all themes -- add theme specific mods at end of this file
  (custom-set-faces
   '(helm-header-line-left-margin ((t (:weight bold))))
   '(link ((t (:weight normal :foreground nil))))
   '(linum ((t (:inherit default :foreground "#888" :height 0.75))))
   '(linum-relative-current-face ((t (:inherit linum))))
   '(neo-dir-link-face ((t (:inherit default))))
   '(neo-file-link-face ((t (:inherit neo-link-dir-face :height 0.85))))
   '(show-paren-match ((t (:foreground "yellow" :background "dim gray"))))

   '(font-lock-comment-face ((t ( :slant italic))))
   '(font-lock-comment-delimiter-face ((t ( :slant italic))))
   '(font-lock-doc-face ((t ( :slant italic))))
   '(font-lock-keyword-face ((t ( :weight bold))))
   '(font-lock-function-name-face ((t ( :weight bold))))
   '(font-lock-constant-face ((t ( :weight normal))))

   '(mode-line-active ((t (:inherit powerline-active2 :background nil))))
   '(mode-line-inactive ((t (:inherit mode-line-inactive :background nil))))
   '(mode-line-buffer-id ((t (:inherit mode-line-inactive :background nil :weight normal))))
   '(mode-line-buffer-size ((t (:inherit font-lock-comment-face :italic nil ))))
   '(powerline-inactive1 ((t (:inherit font-lock-comment-face :italic nil :box t))))
   '(powerline-inactive2 ((t (:inherit powerline-inactive1 :box t))))

   '(magit-diff-base ((t ( :background nil))))
   '(magit-diff-base-highlight ((t ( :background nil))))
   '(magit-diff-hunk-heading ((t (:inherit default  :background nil :weight bold))))
   '(magit-diff-hunk-heading-selection ((t (:inherit default  :background nil :weight bold))))
   '(magit-diff-hunk-heading-highlight ((t (:inherit default  :background nil :weight bold))))
   '(magit-diff-context ((t ( :background nil))))
   '(magit-diff-context-highlight ((t (  :background nil))))

   '(company-tooltip-mouse ((t (:inherit company-tooltip :foreground nil :background nil))))

   '(ediff-odd-diff-A ((t (:inherit font-lock-type-face))))
   '(ediff-odd-diff-B ((t (:inherit font-lock-type-face))))
   '(ediff-odd-diff-C ((t (:inherit font-lock-type-face))))
   '(ediff-even-diff-A ((t (:inherit font-lock-type-face))))
   '(ediff-even-diff-B ((t (:inherit font-lock-type-face))))
   '(ediff-even-diff-C ((t (:inherit font-lock-type-face))))
   )
  )

;; TODO: move common mods above to matt-customize-themes
;; Theme modifications
(setq-default
 theming-modifications
 '(
   (atom-one-dark

    (helm-source-header :foreground "#3E4450" :weight normal)

    (powerline-active1 :inherit font-lock-comment-face :italic nil :box (:color "#3E4450"))
    (mode-line :inherit powerline-active1 :foreground nil :weight normal :box (:color "#3E4450"))
    (powerline-active2 :inherit powerline-active1 :background nil  :box (:color "#3E4450"))

    (magit-diff-added :inherit default :foreground "#7FC682" :background nil)
    (magit-diff-added-highlight :inherit default :foreground "#7FC682" :background nil)
    (diff-refine-added :inherit magit-diff-added :background "#3E4450" )

    (magit-diff-removed :inherit default :foreground "#E16262" :background nil)
    (magit-diff-removed-highlight :inherit default :foreground "#E16262" :background nil)
    (diff-refine-removed :inherit magit-diff-removed :background "#3E4450" )

    )
   (solarized-light

    (magit-diff-added :inherit default :foreground "#859821" :background "#EEE8D6")
    (magit-diff-added-highlight :inherit default :foreground "#859821" :background "#EEE8D6")
    (diff-refine-added :inherit magit-diff-added :foreground "#859900" )

    (magit-diff-removed :inherit default :foreground "red" :background "#EEE8D6")
    (magit-diff-removed-highlight :inherit default :foreground "red" :background "#EEE8D6")
    (diff-refine-removed :inherit magit-diff-added :foreground "#DC322F" )

    )
   )
 )
;; work around custom themes not being applied at Emacs startup
(spacemacs/load-theme 'atom-one-dark)
(matt-customize-themes)
