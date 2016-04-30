(setq projectile-require-project-root t)

(add-to-list 'projectile-globally-ignored-files '"TAGS")
(add-to-list 'projectile-globally-ignored-files '"undo-tree")
(add-to-list 'projectile-globally-ignored-directories '"__pycache__")

;; (defun projectile-idle-regenerate-tags ()
;;   "Regenerate the project's tags if in a project"
;;   (when (projectile-project-p)
;;     (projectile-regenerate-tags)))

;; regenerate TAGS file if idle for 90 seconds
;; (setq projectile-idle-timer (run-with-idle-timer 90 t 'projectile-idle-regenerate-tags))
;; (setq projectile-idle-timer (run-with-idle-timer 300 t 'projectile-invalidate-cache))
;; (setq tags-revert-without-query 1)

(run-with-timer 0 (* 20 60) 'recentf-cleanup)

;; run after n seconds of idle time
(setq recentf-auto-cleanup 120)
;;
;; from here to the end of the file, set up a custom helm-projectile find files command
;;
(defun projectile-recently-modified-files ()
  "Return a list of recently modified files in the current project"
  (split-string (shell-command-to-string "MY_ROOT=$(git rev-parse --show-toplevel 2>/dev/null); if [ \"${MY_ROOT}\" != \"\" ]; then cd \"${MY_ROOT}\"; fi; ag -l --nocolor . | head -10000 | xargs stat -c %y\ %n | sort -r | head -100 | cut -c 36-| xargs realpath "))
  )

(defun my-helm-projectile-findutils-transformer (candidates _source)
  (let (non-essential
        (default-directory (helm-default-directory)))
    (cl-loop for i in candidates
             for abs = (expand-file-name
                        (helm-aif (file-remote-p default-directory)
                            (concat it i) i))
             for type = (car (file-attributes abs))
             for disp = (if (and t
                                 (not (string-match "[.]\\{1,2\\}$" i)))
                            (replace-regexp-in-string (projectile-project-root) "" abs) abs)
             collect (cond ((eq t type)
                            (cons (propertize disp 'face 'helm-ff-directory)
                                  abs))
                           ((stringp type)
                            (cons (propertize disp 'face 'helm-ff-symlink)
                                  abs))
                           (t (cons (propertize disp 'face 'helm-ff-file)
                                    abs))))))

(require 'helm)
(require 'helm-projectile)

(defvar helm-source-projectile-recently-modified-files
  (helm-build-sync-source "Recently Modified in Project"
    :candidates 'projectile-recently-modified-files
    :filtered-candidate-transformer 'my-helm-projectile-findutils-transformer
    :keymap helm-projectile-find-file-map
    :action 'helm-projectile-file-actions))
(helm-projectile-command "find-recently-modified" '(helm-source-projectile-recently-modified-files) "" t)

(helm-projectile-command "custom-find" '(
                                         ;; helm-source-projectile-recently-modified-files
                                         helm-source-projectile-recentf-list
                                         helm-source-projectile-files-list
                                         helm-source-recentf
                                         helm-source-buffer-not-found)
                         "Custom find file: " t)

(defun custom-find-files ()
  (interactive)
  (neotree-hide)
  (if (and (projectile-project-p) (not (string= (projectile-project-p) user-home-directory)))
      (helm-projectile-custom-find)
    (helm-recentf)
    )
  )
