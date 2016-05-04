(setq-default python-indent-offset 4)

;;;;;;;;;; comint ;;;;;;;;;;;
(setq python-shell-interpreter "ipython")
;; check back later revisit https://github.com/gregsexton/ob-ipython/issues/28
(setq python-shell-completion-native-enable nil)

;; prevent warnings when bulk killing buffers
(setq-default  anaconda-mode-process-fail-hook nil)

;;;;;;;;; virtual environments ;;;;;;;;
(pyvenv-mode 1)
(setq pyvenv-tracking-ask-before-change t)

;; https://github.com/purcell/exec-path-from-shell#usage
(exec-path-from-shell-copy-env "WORKON_HOME")

(defun conda-env-update() (interactive)(shell-command "conda env update"))

(setq jedi:tooltip-method '(popup))
;; (setq jedi:tooltip-method nil)
(setq jedi:complete-on-dot t)
(setq jedi:get-in-function-call-timeout 5000)
(setq jedi:get-in-function-call-delay 500)

;;;;;;;;;;;;; hooks ;;;;;;;;;;;;;;;;
(add-hook 'python-mode-hook
          (function (lambda ()
                      (jedi:setup)
                      (add-to-list 'company-backends 'company-jedi)
                      (setq flycheck-disabled-checkers '(
                                                         ;; python-flake8
                                                         ))
                      )) t)
(add-hook 'inferior-python-mode-hook
          (function (lambda ()
                      (visual-line-mode)
                      )) t)

;; https://github.com/flycheck/flycheck/issues/185#issuecomment-215424092
(flycheck-add-next-checker 'python-pylint 'python-flake8)

;;;;;;;;;;;;;;; keybindings ;;;;;;;
(spacemacs/declare-prefix-for-mode 'python-mode "mx" "python/text")
(evil-leader/set-key-for-mode 'python-mode "xx" 'beautify-python-buffer)
(evil-leader/set-key-for-mode 'python-mode "ss" 'run-python)
(evil-leader/set-key-for-mode 'python-mode "Vu" 'conda-env-update)