;; navigation
(global-evil-matchit-mode 1)
(setq avy-keys '(?f ?d ?s ?a ?g ?h ?u ?k ?l ?q ?w ?e ?r ?t ?y ?i ?o ?j))
;; select jump targets from all windows
(setq avy-all-windows t)

(evil-leader/set-key
  "SPC" 'avy-goto-word-or-subword-1
  )

(define-key evil-normal-state-map "\C-a" 'back-to-indentation)
(define-key evil-insert-state-map "\C-a" 'back-to-indentation)
(define-key evil-insert-state-map "\C-e" 'end-of-line)
(define-key evil-normal-state-map "\C-e" 'end-of-line)

(define-key evil-normal-state-map (kbd "gj") 'evil-next-line)
(define-key evil-normal-state-map (kbd "gk") 'evil-previous-line)

(define-key evil-operator-state-map (kbd "j") 'evil-next-line)
(define-key evil-operator-state-map (kbd "k") 'evil-previous-line)

;; use C-i to jump forward (like Vim; opposite of C-o)
;; http://stackoverflow.com/a/4513683/1163042
(keyboard-translate ?\C-i ?\H-i)
(define-key evil-motion-state-map [?\H-i] 'evil-jump-forward)
(define-key evil-normal-state-map [?\H-i] 'evil-jump-forward)
