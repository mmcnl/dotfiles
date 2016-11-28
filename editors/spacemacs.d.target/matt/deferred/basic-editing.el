;;;;;;;;;; copy/paste ;;;;;;;;;;

;; note: exluding pbcopy from osx layer and using this in its place
(simpleclip-mode 1)
(global-set-key [(super v)] 'simpleclip-paste)
(global-set-key [(super c)] 'simpleclip-copy)
(global-set-key [(super x)] 'simpleclip-cut)

;; prevent yanked text from polluting system clipboard history
(setq select-enable-clipboard nil)

;;;;;;;;;; escape ;;;;;;;;;;;
(global-set-key (kbd "C-[ C-[") 'evil-escape)
(setq-default evil-escape-key-sequence "fd")
(setq-default evil-escape-delay 0.2)

;;;;;;;;;;; deleting ;;;;;;;;;;;
(delete-selection-mode 1)
(define-key evil-insert-state-map "\C-d" 'evil-delete-char)
(define-key evil-insert-state-map "\C-h" 'evil-delete-backward-char)
(define-key evil-insert-state-map "\C-k" 'kill-line)
(define-key evil-insert-state-map "\C-u" 'kill-start-of-line)
(define-key evil-insert-state-map (kbd "C-w") 'backward-delete-word)
;; for helm and other buffers
(bind-key* "C-w" 'backward-delete-word)

;;;;;;;;;; lines ;;;;;;;;;;;;
(define-key evil-visual-state-map  (kbd "J") 'evil-join)
(define-key evil-normal-state-map (kbd "C-p") 'my-move-text-up )
(define-key evil-normal-state-map (kbd "C-n") 'my-move-text-down )

;;;;; duplicating things ;;;;;;;;;;;
;; clear Spacemacs SPC y command binding to allow using
;; SPC y as a prefix space
(evil-leader/set-key "y" nil)

(evil-leader/set-key
  "yp" 'duplicate-paragraph
  "yy" 'duplicate-current-line-or-region
  )

(defun duplicate-paragraph ()
  (interactive)
  (mark-paragraph)
  (duplicate-current-line-or-region 1))

;; http://rejeep.github.io/emacs/elisp/2010/03/11/duplicate-current-line-or-region-in-emacs.html
(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    ;; added to prevent extra line at bottom
    (if mark-active
        (forward-line -1)
      )
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))

(defun kill-start-of-line ()
  "kill from point to start of line"
  (interactive)
  (kill-line 0))

(defun insert-and-indent-line-above ()
  (interactive)
  (push-mark)
  (let*
      ((ipt (progn (back-to-indentation) (point)))
       (bol (progn (move-beginning-of-line 1) (point)))
       (indent (buffer-substring bol ipt)))
    (newline)
    (forward-line -1)
    (insert indent)))

;; allow delete backward word in helm
(defun backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word. With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (backward-word arg) (point))))

(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg))
        (forward-line -1))
      (move-to-column column t)))))

(defun my-move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun my-move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))
