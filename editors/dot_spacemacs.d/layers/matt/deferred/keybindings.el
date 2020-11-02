;; set command key (⌘) combinations (mapped to hyper)
(global-set-key [(hyper s)] 'exit-insert-and-save-buffer-always)
(global-set-key [(hyper n)] 'new-tmp-buffer)
(global-set-key [(hyper w)] (lambda () (interactive) (delete-frame)))
(global-set-key [(hyper h)] 'ns-do-hide-emacs)
(global-set-key [(hyper meta h)] 'ns-do-hide-others)

(global-set-key [(hyper u)] 'revert-buffer)


(define-key evil-normal-state-map (kbd "!") 'shell-command)
(define-key evil-visual-state-map (kbd "!") 'shell-command)
(define-key evil-normal-state-map (kbd ":") 'helm-M-x)
(define-key evil-visual-state-map (kbd ":") 'helm-M-x)
(define-key evil-motion-state-map (kbd ":") 'helm-M-x)

(define-key evil-insert-state-map (kbd "C-y") 'yas-expand)

(evil-leader/set-key
  "/" 'spacemacs/helm-project-smart-do-search
  ":" 'evil-ex
  "ba" 'mark-whole-buffer
  "bd" 'kill-this-buffer
  "be" 'erase-buffer
  "bn" 'new-empty-buffer
  "ce" 'clear-previous-comint-buffer
  "od" 'dash-at-point
  "og" 'google-this-noconfirm
  "ot" 'matt-cycle-themes
  "en" 'flycheck-next-error
  "ep" 'flycheck-previous-error
  "fyy" 'custom-copy-file-name-to-clipboard
  "fn" 'find-next-file
  "fp" 'find-previous-file
  "fs" 'exit-insert-and-save-buffer-always
  "ha" 'helm-apropos
  "pK" 'projectile-kill-other-buffers
  "pm" 'helm-projectile-find-recently-modified
  ;; "sr" 'custom-evil-search-replace
  "tl" 'visual-line-mode
  "xL" 'lorem-ipsum-insert-paragraphs
  "xW" 'whitespace-cleanup-buffer
  ","  'feng-goto-last-change
  )
;; "bN" 'evil-window-vnew

;; https://github.com/zenozeng/yafolding.el#modify-keybindings
(require 'yafolding)
(define-key yafolding-mode-map (kbd "<H-M-return>") 'yafolding-toggle-element)
(define-key yafolding-mode-map (kbd "<C-M-return>") nil)
(define-key yafolding-mode-map (kbd "<C-S-return>")  nil)
(define-key yafolding-mode-map (kbd "<C-return>") nil)
