(global-evil-matchit-mode 1)
(delete-selection-mode 1)
(global-auto-revert-mode)

(show-paren-mode 1)
(show-smartparens-global-mode -1)

(setq avy-keys '(?f ?d ?s ?a ?g ?h ?u ?k ?l ?q ?w ?e ?r ?t ?y ?i ?o ?j))

(require 'recentf)
(add-to-list 'recentf-exclude "TAGS$")
(add-to-list 'recentf-exclude "undo-tree")

(setq kill-ring-max 500)
(setq extended-command-history-max 50)
(setq query-replace-history-max 50)
(setq replace-string-history-max 50)
(setq file-name-history-max 50)
(setq replace-regex-history-max 50)
(setq minibuffer-history-max 200)
(setq shell-command-history-max 200)
(setq find-file-history-max 200)

(setq which-key-popup-type 'minibuffer)

(setq-default dotspacemacs-configuration-layers
              '((spell-checking :variables spell-checking-enable-by-default nil)))

(setq which-key-allow-evil-operators nil)
(setq which-key-side-window-max-width 100)

(setq confirm-nonexistent-file-or-buffer nil)

(setq whitespace-style (quote
                        (face tabs trailing
                              space-before-tab
                              lines-tail indentation
                              space-after-tab tab-mark )))

;; prefer vertical splits for opening files from helm
;; http://stackoverflow.com/a/7998271
(setq split-height-threshold nil)
(setq split-width-threshold 0)

;; http://emacs.stackexchange.com/questions/14802/never-keep-current-list-of-tags-tables-also
(setq tags-add-tables nil)

(fset 'yes-or-no-p 'y-or-n-p)
(setq org-return-follows-link t)

;; (setq js2-basic-offset 2)

;; Ignore .DS_Store files with ido mode
(add-to-list 'ido-ignore-files "\\.DS_Store")

;; Makes (setq org-return-follows-link t) work
;; (define-key evil-normal-state-map (kbd "RET") 'org-return)

;; select jump targets from all windows
(setq avy-all-windows t)

(setq-default truncate-lines t)
(smartparens-mode t)

;; don't create .#filename lock files
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/File-Locks.html
(setq create-lockfiles nil)

;; persist kill-ring between restarts
;; http://emacs.stackexchange.com/a/642/10014
(savehist-mode 1)
(add-to-list 'savehist-additional-variables 'kill-ring)

;; midnight-mode may not be available on all emacs versions
(ignore-errors
  ;; https://www.emacswiki.org/emacs/MidnightMode
  (require 'midnight)
  (midnight-mode 1)
  (setq midnight-period 43200) ;; run every 12 hours
  )

;; ;; https://www.emacswiki.org/emacs/CleanBufferList
;; ;; clean up buffers that haven't been touched in 1 day
(setq clean-buffer-list-delay-general 1)

;; prevent these files from being excluded from recentf
(setq open-junk-file-format "/tmp/spacemacs-junk/%Y-%m-%d_%H-%M-%S.")

;; follow end of compilation buffer http://stackoverflow.com/q/4657142/1163042
(setq compilation-scroll-output 'first-error)

;; add missing newline on file save
(setq-default require-final-newline t)

;; allow sh-shellcheck to lint files
(add-hook 'sh-mode-hook
          (lambda ()
            (sh-set-shell "bash")))
