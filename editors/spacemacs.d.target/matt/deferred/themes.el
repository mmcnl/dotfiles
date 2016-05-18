(defun matt-cycle-themes()
  (interactive)
  (when (equal major-mode 'org-mode)
    ;; fix an issue with org-hide not hiding leading stars
    (org-indent-mode)
    (org-indent-mode)
    )
  (spacemacs/cycle-spacemacs-theme)
  (matt-customize-themes)
  )

(defun matt-customize-themes()
  ;; mods common to all themes -- add theme specific mods at end of this file
  (custom-set-faces
   '(helm-header-line-left-margin ((t (:weight bold))))
   '(link ((t (:weight normal :foreground nil))))
   '(linum ((t (:inherit default :foreground "#888" :height 0.65))))
   '(nlinum-relative-current-face ((t (:inherit linum))))
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
   '(magit-diff-context ((t ( :background nil))))
   '(magit-diff-context-highlight ((t (  :background nil))))
   '(magit-diff-hunk-heading ((t (:inherit default  :background nil :weight normal))))
   '(magit-diff-hunk-heading-highlight ((t (:inherit default :background nil :weight normal))))
   '(magit-diff-hunk-heading-selection ((t (:inherit default :background nil :weight normal))))

   '(company-tooltip-mouse ((t (:inherit company-tooltip :foreground nil :background nil))))

   '(ediff-odd-diff-A ((t (:inherit font-lock-type-face))))
   '(ediff-odd-diff-B ((t (:inherit font-lock-type-face))))
   '(ediff-odd-diff-C ((t (:inherit font-lock-type-face))))
   '(ediff-even-diff-A ((t (:inherit font-lock-type-face))))
   '(ediff-even-diff-B ((t (:inherit font-lock-type-face))))
   '(ediff-even-diff-C ((t (:inherit font-lock-type-face))))
   )
  )

(setq-default
 theming-modifications
 '(
   (atom-one-dark
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (diff-refine-added :inherit magit-diff-added :background "#3E4450" )
    (diff-refine-removed :inherit magit-diff-removed :background "#3E4450" )
    (helm-source-header :foreground "#3E4450" :weight normal)
    (magit-diff-added :inherit default :foreground "#7FC682" :background "#2F343D" )
    (magit-diff-added-highlight :inherit magit-diff-added)
    (magit-diff-file-heading :inherit default  :background "#3E4450" :weight normal )
    (magit-diff-file-heading-highlight :inherit magit-diff-file-heading)
    (magit-diff-file-heading-selection :inherit magit-diff-file-heading)
    (magit-diff-removed :inherit default :foreground "#E16262" :background "#2F343D")
    (magit-diff-removed-highlight :inherit magit-diff-removed)
    (mode-line :inherit powerline-active1 :foreground nil :weight normal :box (:color "#3E4450"))
    (neo-file-link-face :foreground "#8D9EB3" :height 0.85)
    (neo-dir-link-face :foreground "#888")
    (org-hide :foreground "#282C34") ;; match background color to hide stars
    (org-level-1 :foreground "#D19A66")
    (org-level-2 :foreground "#BB5D66")
    (org-level-3 :foreground "#906CA2")
    (org-level-4 :foreground "#6A6F7C")
    (org-level-5 :foreground "#5A4369")
    ;; see also org-mode-mellow-default in org-mode.el
    (powerline-active1 :inherit font-lock-comment-face :italic nil :box (:color "#3E4450"))
    (powerline-active2 :inherit powerline-active1 :background nil  :box (:color "#3E4450"))
    )

   (solarized-light
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (diff-refine-added :inherit magit-diff-added :foreground "#859900" )
    (diff-refine-removed :inherit magit-diff-added :foreground "#DC322F" )
    (magit-diff-added :inherit default :foreground "#859821" :background "#EEE8D6")
    (magit-diff-added-highlight :inherit default :foreground "#859821" :background "#EEE8D6")
    (magit-diff-removed :inherit default :foreground "red" :background "#EEE8D6")
    (magit-diff-removed-highlight :inherit default :foreground "red" :background "#EEE8D6")
    (neo-dir-link-face :foreground "#268BD2")
    (neo-file-link-face :height 0.85)
    (org-hide :foreground "#FDF6E4") ;; match background color to hide stars
    )
   )
 )
;; work around custom themes not being applied at Emacs startup
(spacemacs/load-theme 'atom-one-dark)
(matt-customize-themes)

(with-eval-after-load 'nlinum-relative
  (setq-default
   nlinum-relative-current-symbol " "
   nlinum-format "%2s"
   nlinum-relative-format "%2s "
   )
  )

(setq hl-paren-colors '("SpringGreen3"
                        "DarkGreen"
                        "orange"
                        "blue"
                        "yellow"
                        "SkyBlue"
                        ))

(setq-default fringe-indicator-alist '((truncation . (right-arrow right-arrow right-arrow)) (continuation . right-curly-arrow)))
