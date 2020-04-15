(global-auto-revert-mode)

;; don't create .#filename lock files
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/File-Locks.html
(setq create-lockfiles nil)

(setq confirm-nonexistent-file-or-buffer nil)

;; prevent these files from being excluded from recentf
(setq open-junk-file-format "/tmp/spacemacs-junk/%Y-%m-%d_%H-%M-%S.")

;; Ignore .DS_Store files with ido mode
(add-to-list 'ido-ignore-files "\\.DS_Store")

;; add missing newline on file save
(setq-default require-final-newline t)
