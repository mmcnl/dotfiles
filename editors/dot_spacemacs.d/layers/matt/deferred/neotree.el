(with-eval-after-load 'neotree
  (setq neo-vc-integration nil)
  (setq neo-theme 'arrow)
  (setq-default neo-window-width 30)

  (setq-default neo-show-hidden-files t)
  (setq-default neo-banner-message nil)
  (add-to-list 'neo-hidden-regexp-list "TAGS$")
  (add-to-list 'neo-hidden-regexp-list "__pycache__")

  ;; patched to allow everything but .DS_Store
  ;; this must be run after neotree loads in order to monkeypatch
  (defun neo-util--walk-dir (path)
    "Return the subdirectories and subfiles of the PATH."
    (let* ((full-path (neo-path--file-truename path)))
      (condition-case nil
          (directory-files
           path 'full "^\\([^.]\\|\\.[^D.][^S]\\).*")
        ('file-error
         (message "Walk directory %S failed." path)
         nil))))

  (evilified-state-evilify neotree-mode neotree-mode-map
    (kbd "-") 'custom-neotree-enter-horizontal-split-hide
    (kbd "|") 'custom-neotree-enter-vertical-split-hide
    (kbd "ESC") 'neotree-hide ;; try to prevent getting stuck in defining-kbd-macro
    (kbd "RET") 'custom-neotree-enter-hide
    ;; (kbd "TAB") 'custom-neotree-peek)
    (kbd "TAB") 'neotree-quick-look)
  )
(evil-leader/set-key "fk" 'neotree-find-maybe-in-project)

(defun neotree-find-maybe-in-project ()
  (interactive)
  (if (projectile-project-p)
      ;; then
      (progn
        (neotree-hide)
        (neotree-find-project-root)
        )
    ;; else
    (neotree-find)
    )
  )
(defun custom-neotree-enter-hide ()
  (interactive)
  (neotree-enter)
  (neotree-hide)
  )
(defun custom-neotree-enter-vertical-split-hide ()
  (interactive)
  (neotree-enter-vertical-split)
  (neotree-hide)
  )
(defun custom-neotree-enter-horizontal-split-hide ()
  (interactive)
  (neotree-enter-horizontal-split)
  (neotree-hide)
  )
(defun custom-neotree-peek ()
  (interactive)
  (neotree-enter)
  (winum-select-window-1)
  )
