(defun matt-customize-themes()
  (interactive)
  ;; (when (equal major-mode 'org-mode)
  ;;   ;; fix an issue with org-hide not hiding leading stars
  ;;   (org-indent-mode)
  ;;   (org-indent-mode)
  ;;   )
  (custom-set-faces ;; all themes
   '(company-tooltip-mouse ((t (:inherit company-tooltip :foreground nil :background nil))))
   '(font-lock-comment-delimiter-face ((t ( :slant italic))))
   '(font-lock-comment-face ((t ( :slant italic))))
   '(font-lock-constant-face ((t ( :weight normal))))
   '(font-lock-doc-face ((t ( :slant italic))))
   '(font-lock-function-name-face ((t ( :weight bold))))
   '(helm-header-line-left-margin ((t (:weight bold))))
   '(link ((t (:weight normal :foreground nil))))
   '(neo-dir-link-face ((t (:foreground "#268BD2"))))
   '(neo-file-link-face ((t (:height 0.85))))
   '(show-paren-match ((t (:foreground "yellow" :background "dim gray"))))

   )

  (when (string-equal spacemacs--cur-theme "atom-one-dark")

    (custom-set-faces
     '(org-hide    ((t (:foreground "#282C34")))) ;; match background color to hide stars

     '(org-level-1 ((t ( :foreground "#D19A66"))))
     '(org-level-2 ((t ( :foreground "#906CA2"))))
     '(org-level-3 ((t ( :foreground "#BB5D66"))))
     '(org-level-4 ((t ( :foreground "#6A6F7C"))))
     '(org-level-5 ((t ( :foreground "#5A4369"))))
     '(org-level-6 ((t ( :foreground "#5C636F"))))
     '(hl-line ((t (:background "#313741"))))

     '(mode-line           ((t (:height 0.95    :inherit powerline-active0 :foreground "#5C636F" :background "#21252B"))))
     '(mode-line-inactive  ((t (:height 0.95    :inherit powerline-inactive0 :background "#282C34"))))
     '(powerline-active1   ((t (:height 0.95    :inherit powerline-active0 :foreground "#5C636F" :background "#21252B" ))))
     '(powerline-active2   ((t (:height 0.95    :inherit powerline-active0 :foreground "#5C636F"  :background "#21252B"))))
     '(powerline-inactive1  ((t (:height 0.95    :inherit powerline-inactive0 :background "#282C34"))))
     '(powerline-inactive2  ((t (:height 0.95    :inherit powerline-inactive0 :background "#282C34"))))

     '(font-lock-constant-face ((t ( :foreground "#CE6768" :weight normal))))
     '(helm-source-header ((t (:foreground "#3E4450" :weight normal))))
     '(line-number ((t (:inherit default :foreground "#4C5062" :height 0.65))))
     '(line-number-current-line ((t (:inherit default :foreground "#595D6F" :height 0.65))))
     '(neo-dir-link-face ((t (:foreground "#888"))))
     '(neo-file-link-face ((t (:foreground "#8D9EB3" :height 0.85))))

     '(magit-diff-added ((t (:foreground "LightGreen"))))
     '(magit-diff-added-highlight ((t (:foreground "LightGreen"))))
     '(magit-diff-removed ((t (:foreground "red"))))
     '(magit-diff-removed-highlight ((t (:foreground "red"))))
     ;; '(magit-diff-base ((t ())))
     ;; '(magit-diff-highlight ((t ())))
     ;; '(magit-diff-hunk-line ((t ())))
     )
    )
  (when (string-equal spacemacs--cur-theme "solarized-light")
    (custom-set-faces
     '(mode-line           ((t  (:height 0.95 :foreground "#666" :background "#EEE8D6" :box nil))))
     '(powerline-active1   ((t  (:height 0.95 :foreground "#666" :background "#EEE8D6" :box nil))))
     '(powerline-active2   ((t  (:height 0.95 :foreground "#666" :background "#EEE8D6" :box nil))))
     '(mode-line-inactive  ((t  (:height 0.95 :background "#FDF6E4" :box nil))))
     '(powerline-inactive1  ((t (:height 0.95 :background "#FDF6E4" :box nil))))
     '(powerline-inactive2  ((t (:height 0.95 :background "#FDF6E4" :box nil))))

     ;; '(org-level-1 ((t (:weight normal))))
     ;; '(org-level-2 ((t (:weight normal))))
     ;; '(org-level-3 ((t (:weight normal))))
     ;; '(org-level-4 ((t (:weight normal))))
     ;; '(org-level-5 ((t (:weight normal))))
     ;; '(org-level-6 ((t (:weight normal))))


     '(line-number ((t (:inherit default :foreground "#E4DDCB" :height 0.65))))
     '(line-number-current-line ((t (:inherit default :foreground "#CBC4B2" :height 0.65))))
     '(org-hide ((t :foreground "#FDF6E4"))) ;; match background color to hide stars
     '(hl-line ((t (:background "#E4DDCB"))))
     )
    )
  )
(add-hook 'spacemacs-post-theme-change-hook 'matt-customize-themes)

(defun matt-cycle-themes()
  (interactive)
  (spacemacs/cycle-spacemacs-theme)
  (matt-customize-themes)
  (if (derived-mode-p 'org-mode) (org-mode))
  )

(setq hl-paren-colors '("SpringGreen3"
                        "DarkGreen"
                        "orange"
                        "blue"
                        "yellow"
                        "SkyBlue"
                        ))

(setq-default fringe-indicator-alist '((truncation . (right-arrow right-arrow right-arrow)) (continuation . right-curly-arrow)))

;; ;; == != ~= === !== <!-- <-- <- -> --> <= >= => <=> ++ ::
;; ;; https://github.com/tonsky/FiraCode/wiki/Emacs-instructions
;; (let ((alist '(
;;                (33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
;;                (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
;;                (36 . ".\\(?:>\\)")
;;                (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
;;                (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
;;                (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
;;                (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
;;                (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
;;                ;; (46 . ".\\(?:\\(?:\\.[.<]\\)\\|[.=-]\\)") ;; https://github.com/tonsky/FiraCode/issues/42
;;                (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
;;                (48 . ".\\(?:x[a-zA-Z]\\)")
;;                (58 . ".\\(?:::\\|[:=]\\)")
;;                (59 . ".\\(?:;;\\|;\\)")
;;                (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
;;                (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
;;                (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
;;                (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
;;                (91 . ".\\(?:]\\)")
;;                (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
;;                (94 . ".\\(?:=\\)")
;;                (119 . ".\\(?:ww\\)")
;;                (123 . ".\\(?:-\\)")
;;                (124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
;;                (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)")
;;                )
;;              ))
;;   (dolist (char-regexp alist)
;;     (set-char-table-range composition-function-table (car char-regexp)
;;                           `([,(cdr char-regexp) 0 font-shape-gstring]))))

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (diff-refine-added :inherit magit-diff-added :foreground "#859900" )
;; (diff-refine-removed :inherit magit-diff-added :foreground "#DC322F" )
;; (magit-diff-added :inherit default :foreground "#859821" :background "#EEE8D6")
;; (magit-diff-added-highlight :inherit default :foreground "#859821" :background "#EEE8D6")
;; (magit-diff-removed :inherit default :foreground "red" :background "#EEE8D6")
;; (magit-diff-removed-highlight :inherit default :foreground "red" :background "#EEE8D6")


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (diff-refine-added :inherit magit-diff-added :foreground "#859900" )
;; (diff-refine-removed :inherit magit-diff-added :foreground "#DC322F" )
;; (magit-diff-added :inherit default :foreground "#859821" :background "#EEE8D6")
;; (magit-diff-added-highlight :inherit default :foreground "#859821" :background "#EEE8D6")
;; (magit-diff-removed :inherit default :foreground "red" :background "#EEE8D6")
;; (magit-diff-removed-highlight :inherit default :foreground "red" :background "#EEE8D6")
;; '(magit-diff-added ((t (:inherit default :foreground "#7FC682" :background "#2F343D" ))))
;; '(magit-diff-added-highlight ((t (:inherit magit-diff-added))))
;; '(magit-diff-file-heading ((t (:inherit default  :background "#3E4450" :weight normal ))))
;; '(magit-diff-file-heading-highlight ((t (:inherit magit-diff-file-heading))))
;; '(magit-diff-file-heading-selection ((t (:inherit magit-diff-file-heading))))
;; '(magit-diff-removed ((t (:inherit default :foreground "#E16262" :background "#2F343D"))))
;; '(magit-diff-removed-highlight ((t (:inherit magit-diff-removed))))

;; '(diff-added ((t (:inherit magit-diff-added  ))))
;; '(diff-added-highlight ((t (:inherit diff-added))))
;; '(diff-file-heading ((t (:inherit default))))
;; '(diff-file-header ((t (:inherit default))))
;; '(diff-removed ((t (:inherit default :foreground "#E16262" :background nil))))
;; '(diff-removed-highlight ((t (:inherit magit-diff-removed))))

;; '(diff-added ((t (:background nil :foreground "dark green" ))))
;; '(diff-removed ((t (:background nil :foreground "red" ))))

;; '(diff-context ((t (:inherit default :foreground "#bbb"))))
;; '(diff-removed ((t (:inherit magit-diff-removed))))

;; '(magit-diff-base ((t ( :background nil))))
;; '(magit-diff-base-highlight ((t ( :background nil))))
;; '(magit-diff-context ((t ( :background nil))))
;; '(magit-diff-context-highlight ((t (  :background nil))))
;; '(magit-diff-hunk-heading ((t (:inherit default  :background nil :weight normal))))
;; '(magit-diff-hunk-heading-highlight ((t (:inherit default :background nil :weight normal))))
;; '(magit-diff-hunk-heading-selection ((t (:inherit default :background nil :weight normal))))
;; '(ediff-odd-diff-A ((t (:inherit font-lock-type-face))))
;; '(ediff-odd-diff-B ((t (:inherit font-lock-type-face))))
;; '(ediff-odd-diff-C ((t (:inherit font-lock-type-face))))
;; '(ediff-even-diff-A ((t (:inherit font-lock-type-face))))
;; '(ediff-even-diff-B ((t (:inherit font-lock-type-face))))
;; '(ediff-even-diff-C ((t (:inherit font-lock-type-face))))
