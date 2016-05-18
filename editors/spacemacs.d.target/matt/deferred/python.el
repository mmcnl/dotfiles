(setq-default python-indent-offset 4)

(add-to-list 'auto-mode-alist '("\\.*\\.pyi\\'" . python-mode))

;;;;;;;;;; comint ;;;;;;;;;;;
(setq python-shell-interpreter "ipython")
;; check back later revisit https://github.com/gregsexton/ob-ipython/issues/28
(setq python-shell-completion-native-enable nil)

;;;;;;;;; virtual environments ;;;;;;;;
(pyvenv-mode 1)
(setq pyvenv-tracking-ask-before-change t)

;; https://github.com/purcell/exec-path-from-shell#usage
(exec-path-from-shell-copy-env "WORKON_HOME")

(defun conda-env-update() (interactive)(shell-command "conda env update"))

;;;;;;;;;; anaconda ;;;;;;;;;;;
;; prevent warnings when bulk killing buffers
(setq-default  anaconda-mode-process-fail-hook nil)

;;;;;;;;;;;;; hooks ;;;;;;;;;;;;;;;;
(add-hook 'python-mode-hook
          (function (lambda ()
                      (setq flycheck-disabled-checkers '(
                                                         python-pylint
                                                         ))
                      (spacemacs/toggle-flycheck-python-mypy-off)
                      )) t)

(add-hook 'inferior-python-mode-hook
          (function (lambda ()
                      (visual-line-mode)
                      )) t)

(add-hook 'anaconda-mode-view-mode-hook
          (function (lambda ()
                      (text-scale-set -1)
                      (visual-line-mode)
                      )) t)

;;;;;;;;;;;;;;; keybindings ;;;;;;;
(spacemacs/declare-prefix-for-mode 'python-mode "mx" "python/text")
(evil-leader/set-key-for-mode 'python-mode "xx" 'beautify-python-buffer)
(evil-leader/set-key-for-mode 'python-mode "ss" 'run-python)
(evil-leader/set-key-for-mode 'python-mode "Vu" 'conda-env-update)

;;;;;;;;;;;;;;; flycheck ;;;;;;;

(require 'flycheck-mypy)

;; after flake8 add pylint
(flycheck-add-next-checker 'python-flake8 'python-pylint)

;; after pylint run mypy if pylint reports no errors or warnings
(flycheck-add-next-checker 'python-pylint `(info . python-mypy))

(setq flycheck-python-mypy-args "--disallow-untyped-calls")

(spacemacs|add-toggle flycheck-python-mypy
  :status (not (member 'python-mypy flycheck-disabled-checkers))
  :on (progn (setq flycheck-disabled-checkers (remq 'python-mypy flycheck-disabled-checkers)))
  :off (progn (add-to-list 'flycheck-disabled-checkers 'python-mypy))
  :documentation "Check python files for proper typing using mypy"
  :evil-leader-for-mode (python-mode . "m"))
