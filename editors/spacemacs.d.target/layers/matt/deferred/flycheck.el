(with-eval-after-load 'flycheck
  ;; disable tooltips
  (flycheck-pos-tip-mode -1)

  ;; disable by default; re-enable in prog-mode-hook
  (global-flycheck-mode -1)

  (defconst flycheck-error-list-format
    `[("File" 8)
      ("Line" 5 flycheck-error-list-entry-< :right-align t)
      ("Col" 3 nil :right-align t)
      ("Level" 8 flycheck-error-list-entry-level-<)
      ("ID" 25 t)
      (,(flycheck-error-list-make-last-column "Message" 'Checker) 0 t)]
    "Table format for the error list.")

  (add-hook 'flycheck-mode-hook
            (function (lambda ()
                        ;; https://github.com/syl20bnr/spacemacs/issues/1097
                        (add-hook 'evil-normal-state-entry-hook 'company-abort)
                        )) t)

  ;; https://gist.github.com/glasser/e8363df7640f2c445460#file-flycheck-top-window-el-L23
  (add-hook 'flycheck-error-list-after-refresh-hook
            (lambda ()
              (with-selected-window (flycheck-get-error-list-window t)
                (text-scale-set -1)
                (fit-window-to-buffer))))

  ;; shell-mode
  (add-to-list 'flycheck-shellcheck-excluded-warnings "SC1090")
  (add-to-list 'flycheck-shellcheck-excluded-warnings "SC1091")
  (add-to-list 'flycheck-shellcheck-excluded-warnings "SC2034")
  )
