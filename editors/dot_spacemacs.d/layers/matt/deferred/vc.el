;; Deleted files are still shown in projectile-find-file (#1148)

;; My workaround was to replace git ls-files with fd:

(setq projectile-git-command "fd . -0 --type f --hidden --color=never")
;; and also creating ~/.fdignore:

;; **/.git/

;;;;;;;;;;; variables ;;;;;;;;;;;;;;

(spacemacs|use-package-add-hook magit
  :pre-init
  ;; Code

  :post-init
  ;; Code

  :pre-config
  ;; Code

  :post-config
  ;; use native apple git
  (setq magit-git-executable "/usr/local/bin/git")

  (remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-pushremote)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-upstream)
  (remove-hook 'magit-status-sections-hook 'magit-insert-status-headers)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-pushremote)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-upstream-or-recent)

  (define-key magit-mode-map (kbd "1") 'magit-section-show-level-1-all)
  (define-key magit-mode-map (kbd "2") 'magit-section-show-level-2-all)
  (define-key magit-mode-map (kbd "3") 'magit-section-show-level-3-all)
  (define-key magit-mode-map (kbd "4") 'magit-section-show-level-4-all)

  (spacemacs/set-leader-keys "gL" nil)
  (spacemacs/declare-prefix "gL" "magit log")
  (spacemacs/set-leader-keys "gLa" 'magit-log-all)
  (spacemacs/set-leader-keys "gLl" 'magit-log-current)
  (spacemacs/set-leader-keys "gLf" 'magit-log-buffer-file)

  (spacemacs/set-leader-keys "gd" nil)
  (spacemacs/declare-prefix "gd" "git diff")
  (spacemacs/set-leader-keys "gdd" 'magit-diff-buffer-file)
  (spacemacs/set-leader-keys "gdw" 'magit-diff-working-tree)
  (spacemacs/set-leader-keys "gds" 'magit-diff-staged)

  (spacemacs/set-leader-keys "gS" 'git-short-status)
  )

;; Magit can be told to refresh buffers verbosely using M-x
;; magit-toggle-verbose-refresh. Enabling this helps figuring out which sections
;; are bottlenecks. The additional output can be found in the *Messages* buffer.

(setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
(setq magit-diff-refine-hunk nil)

;; https://emacs.stackexchange.com/questions/14483/magit-log-dates#comment67151_40832
(setq magit-log-margin '(t "%Y-%m-%d %H:%M " magit-log-margin-width t 18))

;; http://stackoverflow.com/a/30900018
(setq vc-follow-symlinks t)

;; show commit info for line in popup
(setq git-messenger:show-detail t)

;; https://magit.vc/manual/magit-popup.html
(setq magit-popup-show-common-commands nil)

(setq git-gutter-fr+-side 'left-fringe)
(setq git-link-use-commit t)

(setq git-timemachine-abbreviation-length 8)

;; https://github.com/justbur/evil-magit
(setq evil-magit-want-horizontal-movement t)

;;;;;;;;;;;;;;;; keybindings ;;;;;;;;;;;;;;;;;;;

(define-key evil-normal-state-map (kbd "]h") 'git-gutter+-next-hunk)
(define-key evil-normal-state-map (kbd "[h") 'git-gutter+-previous-hunk)

(evil-leader/set-key
  "as" 'stree
  "gB" 'tig-blame-current-file
  "gU" 'vc-revert
  "gX" 'spacemacs/vcs-revert-hunk
  "ga" 'git-add-all-commit
  )
;;;;;;;;;;;;;;;; advice ;;;;;;;;;;;;;;;;;;;

(defadvice vc-buffer-sync (before save-before-new activate)
  "Save buffer before vc calls."
  (save-buffer)
  )

(defadvice spacemacs/magit-diff-head (before save-before-diff activate)
  "Save all buffers first."
  (evil-write-all nil)
  )

(defadvice git-link--new (after set-clipboard (arg) activate)
  "add to system clibpoard"
  (simpleclip-set-contents (current-kill 0))
  )

(defadvice git-timemachine-kill-revision (after set-clipboard activate)
  "add to system clibpoard"
  (simpleclip-set-contents (current-kill 0))
  )

;; use short commit hash
(defun git-link--last-commit ()
  (car (git-link--exec "--no-pager" "log" "-n1" "--pretty=format:%h")))

(defadvice vc-diff (after smaller-text activate)
  "wrap vc-diff"
  (text-scale-set -1)
  )

(defadvice spacemacs/magit-diff-head (after collapse-diffs activate)
  "collapse diffs"
  (magit-section-show-level-1-all)
  (text-scale-set -1)
  )

;;;;;;;;;;;;;;; functions ;;;;;;;;;;;;;;;;
(defun git-add-all-commit() (interactive)(save-some-buffers t)(shell-command "git add --all")(magit-commit-popup))
(defun git-fetch() (interactive)(shell-command "git fetch --verbose"))
(defun git-short-status() (interactive)(shell-command "git short-status | column -t"))
(defun git-push() (interactive)(shell-command "git push --verbose"))

(defun my-vc-diff(command)
  (interactive)
  (shell-command (format "osascript -e 'tell application \"iTerm\"' -e 'tell current window' -e 'set newTab to (create tab with default profile)' -e 'tell newTab' -e 'activate current session' -e 'tell current session' -e 'write text \"%s\"' -e 'end tell' -e 'end tell' -e 'end tell' -e 'end tell'" command))
  )

(defun send-to-terminal(command)
  (interactive)
  (shell-command (format "osascript -e 'tell application \"iTerm\"' -e 'tell current window' -e 'set newTab to (create tab with default profile)' -e 'tell newTab' -e 'activate current session' -e 'tell current session' -e 'write text \"%s\"' -e 'end tell' -e 'end tell' -e 'end tell' -e 'end tell'" command))
  )

(defun tig-cd-git-root()
  (format "cd %s; cd $(git rev-parse --show-toplevel); " (file-name-directory (buffer-file-name)))
  )

(defun tig-blame-current-file()
  (interactive)
  (send-to-terminal (format "%s tig blame %s" (tig-cd-git-root) (buffer-file-name)))
  )

(defun stree ()
  "opens SourceTree"
  (interactive)
  (shell-command "stree"))
