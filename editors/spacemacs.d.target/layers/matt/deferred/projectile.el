(with-eval-after-load 'projectile
  (setq projectile-require-project-root t)

  (add-to-list 'projectile-globally-ignored-files '"TAGS")
  (add-to-list 'projectile-globally-ignored-files '"undo-tree")
  (add-to-list 'projectile-globally-ignored-directories '"__pycache__")
  )
;; (defun projectile-idle-regenerate-tags ()
;;   "Regenerate the project's tags if in a project"
;;   (when (projectile-project-p)
;;     (projectile-regenerate-tags)))

;; regenerate TAGS file if idle for 90 seconds
;; (setq projectile-idle-timer (run-with-idle-timer 90 t 'projectile-idle-regenerate-tags))
;; (setq projectile-idle-timer (run-with-idle-timer 300 t 'projectile-invalidate-cache))
;; (setq tags-revert-without-query 1)

;;
;; from here to the end of the file, set up a custom helm-projectile find files command
;;
(defun projectile-recently-modified-files ()
  "Return a list of recently modified files in the current project"
  (split-string (shell-command-to-string "recent_files_in_project"))
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
                                         helm-source-buffers-list
                                         helm-source-projectile-buffers-list
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

(defun projectile-kill-other-buffers ()
  "Kill all buffers from other projects."
  (interactive)
  (let ((name (projectile-project-name))
        (buffers (projectile-project-other-buffers)))
    (if (yes-or-no-p
         (format "Are you sure you want to kill %d buffer(s) for buffers other than '%s'? "
                 (length buffers) name))
        ;; we take care not to kill indirect buffers directly
        ;; as we might encounter them after their base buffers are killed
        (mapc #'kill-buffer (-remove 'buffer-base-buffer buffers)))))

(defun projectile-project-other-buffers ()
  "Get a list of project buffers."
  (interactive)
  (require 'cl)
  (set-difference (buffer-list)(projectile-project-buffers))
  )
