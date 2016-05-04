;;;;;;;;;;; variables ;;;;;;;;;;;;;;

;; http://stackoverflow.com/a/30900018
(setq vc-follow-symlinks t)

;; show commit info for line in popup
(setq git-messenger:show-detail t)

;; https://magit.vc/manual/magit-popup.html
(setq magit-popup-show-common-commands nil)

(setq git-gutter-fr+-side 'left-fringe)
(setq git-link-use-commit t)

(setq git-timemachine-abbreviation-length 8)
(setq magit-diff-refine-hunk 'all)

;; https://github.com/justbur/evil-magit
(setq evil-magit-want-horizontal-movement t)

;;;;;;;;;;;;;;;; keybindings ;;;;;;;;;;;;;;;;;;;

(with-eval-after-load 'magit
  (define-key magit-mode-map (kbd "1") 'magit-section-show-level-1-all)
  (define-key magit-mode-map (kbd "2") 'magit-section-show-level-2-all)
  (define-key magit-mode-map (kbd "3") 'magit-section-show-level-3-all)
  (define-key magit-mode-map (kbd "4") 'magit-section-show-level-4-all)
  )

(define-key evil-normal-state-map (kbd "]h") 'git-gutter+-next-hunk)
(define-key evil-normal-state-map (kbd "[h") 'git-gutter+-previous-hunk)

(evil-leader/set-key
  "as" 'stree
  "gB" 'tig-blame-current-file
  "gl" 'magit-log-all
  "gP" 'git-push
  "gS" 'git-short-status
  "gU" 'vc-revert
  "ga" 'git-add-all-commit
  "gf" 'git-fetch
  "gs" 'magit-status
  "gv" 'vc-diff
  "gX" 'version-control/revert-hunk
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
(defun whitespace-cleanup-buffer() (interactive)(ws-butler-clean-region (point-min)(point-max)))
(defun new-empty-buffer() (interactive)(spacemacs/new-empty-buffer)(text-mode))

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
