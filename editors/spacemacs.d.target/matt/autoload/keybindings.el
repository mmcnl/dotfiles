(defun stree ()
  "opens SourceTree"
  (interactive)
  (shell-command "stree"))

(defun simulate-key-press (key)
  "Return a command that pretends KEY was presssed.
KEY must be given in `kbd' notation."
  `(lambda () (interactive)
     (setq prefix-arg current-prefix-arg)
     (setq unread-command-events (listify-key-sequence (read-kbd-macro ,key)))))

(global-set-key (kbd "C-[ C-[") 'evil-escape)

;; for helm and other buffers
(bind-key* "C-w" 'backward-delete-word)

(with-eval-after-load 'magit
  (define-key magit-mode-map (kbd "1") 'magit-section-show-level-1-all)
  (define-key magit-mode-map (kbd "2") 'magit-section-show-level-2-all)
  (define-key magit-mode-map (kbd "3") 'magit-section-show-level-3-all)
  (define-key magit-mode-map (kbd "4") 'magit-section-show-level-4-all)
  )

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd ":") 'helm-M-x)
  (define-key dired-mode-map [return] 'dired-single-buffer)
  (define-key dired-mode-map "-"
    (function
     (lambda nil (interactive) (dired-single-buffer ".."))))
  )

(global-set-key [(control tab)]  'mybuffers-switch)
(global-set-key [(super a)] 'mark-whole-buffer)
(global-set-key [(super v)] 'simpleclip-paste)
(global-set-key [(super c)] 'simpleclip-copy)
(global-set-key [(super x)] 'simpleclip-cut)

(global-set-key [(super n)] 'new-tmp-buffer)
(global-set-key [(super s)] 'exit-insert-and-save-buffer-always)
(global-set-key [(super w)] (lambda () (interactive) (delete-frame)))

(define-key evil-insert-state-map "\C-a" 'beginning-of-line)
(define-key evil-insert-state-map "\C-e" 'end-of-line)
(define-key evil-insert-state-map "\C-d" 'evil-delete-char)
(define-key evil-insert-state-map "\C-h" 'evil-delete-backward-char)
(define-key evil-insert-state-map "\C-k" 'kill-line)
(define-key evil-insert-state-map "\C-u" 'kill-start-of-line)
(define-key evil-insert-state-map (kbd "C-w") 'backward-delete-word)
(define-key evil-insert-state-map (kbd "C-y") 'company-yasnippet)

(define-key evil-normal-state-map (kbd "!") 'shell-command)
(define-key evil-visual-state-map (kbd "!") 'shell-command)

(define-key evil-normal-state-map (kbd ":") 'helm-M-x)
(define-key evil-visual-state-map (kbd ":") 'helm-M-x)

(define-key evil-normal-state-map (kbd "]h") 'git-gutter+-next-hunk)
(define-key evil-normal-state-map (kbd "[h") 'git-gutter+-previous-hunk)

(global-set-key (kbd "C-0") (lambda() (interactive)(find-file "~/Dropbox/org/todo.org")))

(defun git-add-all-commit() (interactive)(save-buffer)(shell-command "git add --all")(magit-commit-popup))
(defun git-fetch() (interactive)(shell-command "git fetch --verbose"))
(defun git-short-status() (interactive)(shell-command "git short-status | column -t"))
(defun git-push() (interactive)(shell-command "git push --verbose"))
(defun whitespace-cleanup-buffer() (interactive)(ws-butler-clean-region (point-min)(point-max)))
(defun new-empty-buffer() (interactive)(spacemacs/new-empty-buffer)(text-mode))

;; clear Spacemacs SPC y command binding to allow using
;; SPC y as a prefix space
(evil-leader/set-key "y" nil)

(evil-leader/set-key
  "SPC" 'avy-goto-word-or-subword-1
  ":" 'evil-ex
  "/" 'spacemacs/helm-project-smart-do-search
  "as" 'stree
  "bN" 'evil-window-vnew
  "ba" 'mark-whole-buffer
  "bd" 'kill-this-buffer
  "be" 'erase-buffer
  "bn" 'new-empty-buffer
  "dd" 'dash-at-point
  "dg" 'google-this-noconfirm
  "ee" 'eval-expression
  "ff" 'custom-find-files
  "fk" 'neotree-find-maybe-in-project
  "fn" 'find-next-file
  "fp" 'find-previous-file
  "fs" 'exit-insert-and-save-buffer-always
  "fy" 'copy-file-name-to-clipboard
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
  "ha" 'helm-apropos
  "pm" 'helm-projectile-find-recently-modified
  "sr" 'custom-evil-search-replace
  "tn" 'linum-mode
  "tt" 'matt-cycle-themes
  "tl" 'visual-line-mode
  "wS" 'split-window-below
  "wV" 'split-window-right
  "wo" 'delete-other-windows
  "ws" 'split-window-below-and-focus
  "wv" 'split-window-right-and-focus
  "xL" 'lorem-ipsum-insert-paragraphs
  "xW" 'whitespace-cleanup-buffer
  "yy" 'duplicate-current-line-or-region
  )

(define-key evil-visual-state-map  (kbd "J") 'evil-join)
(define-key evil-normal-state-map (kbd "gj") 'evil-next-line)
(define-key evil-normal-state-map (kbd "gk") 'evil-previous-line)

(define-key evil-operator-state-map (kbd "j") 'evil-next-line)
(define-key evil-operator-state-map (kbd "k") 'evil-previous-line)

(define-key evil-normal-state-map (kbd "C-p") 'my-move-text-up )
(define-key evil-normal-state-map (kbd "C-n") 'my-move-text-down )


(define-key evil-normal-state-map (kbd "SPC yp") (simulate-key-press "v a p SPC yy") )

;; insert newline and move cursor down with line
(define-key evil-normal-state-map (kbd "RET") (simulate-key-press "O <escape>") )

(setq-default evil-escape-key-sequence "fd")
(setq-default evil-escape-delay 0.2)

;; use C-i to jump forward (like Vim; opposite of C-o)
;; http://stackoverflow.com/a/4513683/1163042
(keyboard-translate ?\C-i ?\H-i)
(define-key evil-motion-state-map [?\H-i] 'evil-jump-forward)
(define-key evil-normal-state-map [?\H-i] 'evil-jump-forward)
