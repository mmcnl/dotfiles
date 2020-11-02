;; (add-to-list 'auto-mode-alist '("\\.jst.str\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.jin\\'" . web-mode))
;; (setq web-mode-engines-alist
;;       '(("jinja"    . "\\.jin\\'")
;;         ("blade"  . "\\.blade\\."))
;;       )
;; (add-to-list 'auto-mode-alist '("\\.js[x]?\\'" . web-mode))       ;; JS + JSX
(add-hook 'web-mode-hook
          (lambda ()
            (message "customizing web-mode")
            (prettier-js-mode)
            (setq css-indent-offset 2)
            (setq web-mode-markup-indent-offset 2)
            (setq web-mode-css-indent-offset 2)
            (setq web-mode-code-indent-offset 2)
            (setq web-mode-script-padding 2)
            (setq web-mode-attr-indent-offset 2)
            (setq web-mode-enable-css-colorization t)
            (emmet-mode)
            ;; (set (make-local-variable
            ;;       'company-backends) '((
            ;;                             company-web-html
            ;;                             company-css
            ;;                             company-dabbrev
            ;;                             )))
            )
          )

;; use to reset mode
(spacemacs/set-leader-keys-for-major-mode 'web-mode
  "," 'web-mode )

(require 'mmm-mode)
(setq mmm-global-mode 't)

;; https://vxlabs.com/2014/04/08/syntax-highlighting-markdown-fenced-code-blocks-in-emacs/#mmm-mode
(mmm-add-classes
 '((js-css
    :submode css-mode
    :face mmm-declaration-submode-face
    :front "css`$"
    :back "`;?$")))
(mmm-add-mode-ext-class 'js2-mode nil 'js-css)
(mmm-add-mode-ext-class 'typescript-mode nil 'js-css)

(mmm-add-classes
 '((js-web
    :submode web-mode
    :face mmm-declaration-submode-face
    :front "html`"
    :back "`;$")))
(mmm-add-mode-ext-class 'js2-mode nil 'js-web)
(mmm-add-mode-ext-class 'typescript-mode nil 'js-web)

