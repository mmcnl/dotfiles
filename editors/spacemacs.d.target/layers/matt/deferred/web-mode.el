;; (add-to-list 'auto-mode-alist '("\\.jst.str\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.jin\\'" . web-mode))
;; (setq web-mode-engines-alist
;;       '(("jinja"    . "\\.jin\\'")
;;         ("blade"  . "\\.blade\\."))
;;       )
(add-to-list 'auto-mode-alist '("\\.js[x]?\\'" . web-mode))       ;; JS + JSX
(add-hook 'web-mode-hook
          (lambda ()
            (message "customizing web-mode")
            (setq css-indent-offset 2)
            (setq web-mode-markup-indent-offset 2)
            (setq web-mode-css-indent-offset 2)
            (setq web-mode-code-indent-offset 2)
            (setq web-mode-script-padding 2)
            (setq web-mode-attr-indent-offset 2)
            (setq web-mode-enable-css-colorization t)
            ;; (set (make-local-variable
            ;;       'company-backends) '((
            ;;                             company-web-html
            ;;                             company-css
            ;;                             company-dabbrev
            ;;                             )))
            )
          )
