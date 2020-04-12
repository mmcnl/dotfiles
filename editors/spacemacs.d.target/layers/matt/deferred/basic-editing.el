;;;;;;;;;; copy/paste ;;;;;;;;;;

;; note: exluding pbcopy from osx layer and using this in its place
(simpleclip-mode 1)
(global-set-key [(hyper v)] 'simpleclip-paste)
(global-set-key [(hyper c)] 'simpleclip-copy)
(global-set-key [(hyper x)] 'simpleclip-cut)

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

;; http://stackoverflow.com/a/22418983
;; create "il"/"al" (inside/around) line text objects:
(define-and-bind-text-object "l" "^\\s-*" "\\s-*$")
;; create "ie"/"ae" (inside/around) entire buffer text objects:
(define-and-bind-text-object "e" "\\`\\s-*" "\\s-*\\'")

;;;;; duplicating things ;;;;;;;;;;;
;; clear Spacemacs SPC y command binding to allow using
;; SPC y as a prefix space
(evil-leader/set-key "y" nil)

(evil-leader/set-key
  "yp" 'duplicate-paragraph
  "yy" 'duplicate-current-line
  )

(defun duplicate-paragraph ()
  (interactive)
  (mark-paragraph)
  (duplicate-current-line-or-region 1))

;; duplicate current line
(defun duplicate-current-line (&optional n)
  "duplicate current line, make more than 1 copy given a numeric argument"
  (interactive "p")
  (save-excursion
    (let ((nb (or n 1))
          (current-line (thing-at-point 'line)))
      ;; when on last line, insert a newline first
      (when (or (= 1 (forward-line 1)) (eq (point) (point-max)))
        (insert "\n"))

      ;; now insert as many time as requested
      (while (> n 0)
        (insert current-line)
        (decf n)))))

;; ;; http://rejeep.github.io/emacs/elisp/2010/03/11/duplicate-current-line-or-region-in-emacs.html
;; (defun duplicate-current-line-or-region (arg)
;;   "Duplicates the current line or region ARG times.
;; If there's no region, the current line will be duplicated. However, if
;; there's a region, all lines that region covers will be duplicated."
;;   (interactive "p")
;;   (let (beg end (origin (point)))
;;     (if (and mark-active (> (point) (mark)))
;;         (exchange-point-and-mark))
;;     (setq beg (line-beginning-position))
;;     (if mark-active
;;         (exchange-point-and-mark))
;;     ;; added to prevent extra line at bottom
;;     ;; (if mark-active
;;     ;;     (forward-line -1)
;;     ;;   )
;;     (setq end (line-end-position))
;;     (let ((region (buffer-substring-no-properties beg end)))
;;       (dotimes (i arg)
;;         (goto-char end)
;;         (newline)
;;         (insert region)
;;         (setq end (point)))
;;       (goto-char (+ origin (* (length region) arg) arg)))))

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


;; https://web.archive.org/web/20160426152829/http://shenfeng.me/emacs-last-edit-location.html

;;; record two different file's last change. cycle them
(defvar feng-last-change-pos1 nil)
(defvar feng-last-change-pos2 nil)

(defun feng-swap-last-changes ()
  (when feng-last-change-pos2
    (let ((tmp feng-last-change-pos2))
      (setf feng-last-change-pos2 feng-last-change-pos1
            feng-last-change-pos1 tmp))))

(defun feng-goto-last-change ()
  (interactive)
  (when feng-last-change-pos1
    (let* ((buffer (find-file-noselect (car feng-last-change-pos1)))
           (win (get-buffer-window buffer)))
      (if win
          (select-window win)
        (switch-to-buffer-other-window buffer))
      (goto-char (cdr feng-last-change-pos1))
      (feng-swap-last-changes))))

(defun feng-buffer-change-hook (beg end len)
  (let ((bfn (buffer-file-name))
        (file (car feng-last-change-pos1)))
    (when bfn
      (if (or (not file) (equal bfn file)) ;; change the same file
          (setq feng-last-change-pos1 (cons bfn end))
        (progn (setq feng-last-change-pos2 (cons bfn end))
               (feng-swap-last-changes))))))

(add-hook 'after-change-functions 'feng-buffer-change-hook)
