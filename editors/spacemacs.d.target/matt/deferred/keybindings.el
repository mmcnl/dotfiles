(global-set-key [(super s)] 'exit-insert-and-save-buffer-always)

(define-key evil-normal-state-map (kbd "!") 'shell-command)
(define-key evil-visual-state-map (kbd "!") 'shell-command)
(define-key evil-normal-state-map (kbd ":") 'helm-M-x)
(define-key evil-visual-state-map (kbd ":") 'helm-M-x)

(evil-leader/set-key
  "/" 'spacemacs/helm-project-smart-do-search
  ":" 'evil-ex
  "bN" 'evil-window-vnew
  "ba" 'mark-whole-buffer
  "bd" 'kill-this-buffer
  "be" 'erase-buffer
  "bn" 'new-empty-buffer
  "ce" 'clear-previous-comint-buffer
  "dd" 'dash-at-point
  "dg" 'google-this-noconfirm
  "ee" 'eval-expression
  "ff" 'custom-find-files
  "fn" 'find-next-file
  "fp" 'find-previous-file
  "fs" 'exit-insert-and-save-buffer-always
  "fy" 'copy-file-name-to-clipboard
  "ha" 'helm-apropos
  "pK" 'projectile-kill-other-buffers
  "pm" 'helm-projectile-find-recently-modified
  "sr" 'custom-evil-search-replace
  "tl" 'visual-line-mode
  "tt" 'matt-cycle-themes
  "xL" 'lorem-ipsum-insert-paragraphs
  "xW" 'whitespace-cleanup-buffer
  )
