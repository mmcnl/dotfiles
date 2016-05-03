(defun new-tmp-buffer ()
  (interactive)
  (switch-to-buffer-other-frame "*scratch*")
  )

(defun evil-search-file ()
  (interactive)
  (evil-ex "%s/")
  )

(defun exit-insert-and-save-buffer-always ()
  "Enter normal state and save the buffer even if it is not modified."
  (interactive)
  (evil-normal-state)
  (set-buffer-modified-p t)
  (save-buffer))

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

(defun align-single-equals ()
  "Align on a single equals sign (with a space before)."
  (interactive)
  (align-regexp
   (region-beginning) (region-end)
   "\\(\\s-*\\) =" 1 0 nil))

(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (simpleclip-set-contents filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

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

(defun custom-evil-search-replace ()
  (interactive)
  (if (and evil-mode (eq evil-state 'visual))
      (progn
        (evil-ex "'<,'>s/")
        (call-interactively (global-key-binding "\C-g"))
        )
    )
  (if (and evil-mode (eq evil-state 'normal))
      (evil-search-file))
  )

;;  http://emacs.stackexchange.com/a/12156/115
(defun find-next-file (&optional backward)
  "Find the next file (by name) in the current directory.

With prefix arg, find the previous file."
  (interactive "P")
  (when buffer-file-name
    (let* ((file (expand-file-name buffer-file-name))
           (files (cl-remove-if (lambda (file) (cl-first (file-attributes file)))
                                (sort (directory-files (file-name-directory file) t nil t) 'string<)))
           (pos (mod (+ (cl-position file files :test 'equal) (if backward -1 1))
                     (length files))))
      (find-file (nth pos files)))))

(defun find-previous-file () (interactive) (find-next-file t))

(defun ido-sort-mtime ()
  (setq ido-temp-list
        (sort ido-temp-list
              (lambda (a b)
                (time-less-p
                 (sixth (file-attributes (concat ido-current-directory b)))
                 (sixth (file-attributes (concat ido-current-directory a)))))))
  (ido-to-end  ;; move . files to end (again)
   (delq nil (mapcar
              (lambda (x) (and (char-equal (string-to-char x) ?.) x))
              ido-temp-list))))

;; sort ido filelist by mtime instead of alphabetically
(add-hook 'ido-make-file-list-hook 'ido-sort-mtime)
(add-hook 'ido-make-dir-list-hook 'ido-sort-mtime)

(defun tidy-html ()
  "Tidies the HTML content in the buffer using `tidy'"
  (interactive)
  (shell-command-on-region
   ;; beginning and end of buffer
   (point-min)
   (point-max)
   ;; command and parameters
   "tidy -i -w 80 -q"
   ;; output buffer
   (current-buffer)
   ;; replace?
   t
   ;; name of the error buffer
   "*Tidy Error Buffer*"
   ;; show error buffer?
   t))

(defun diff-region ()
  "Select a region to compare"
  (interactive)
  (when (use-region-p)  ; there is a region
    (let (buf)
      (setq buf (get-buffer-create "*Diff-regionA*"))
      (save-current-buffer
        (set-buffer buf)
        (erase-buffer))
      (append-to-buffer buf (region-beginning) (region-end)))
    )
  (message "Now select other region to compare and run `diff-region-now`")
  )

(defun diff-region-now ()
  "Compare current region with region already selected by `diff-region`"
  (interactive)
  (when (use-region-p)
    (let (bufa bufb)
      (setq bufa (get-buffer-create "*Diff-regionA*"))
      (setq bufb (get-buffer-create "*Diff-regionB*"))
      (save-current-buffer
        (set-buffer bufb)
        (erase-buffer))
      (append-to-buffer bufb (region-beginning) (region-end))
      (ediff-buffers bufa bufb))
    )
  )

(add-hook 'ediff-startup-hook
          (lambda ()
            (local-set-key (kbd"q") 'my-ediff-quit)))

(defun my-ediff-quit ()
  "If any of the ediff buffers have been modified, ask if changes
should be saved. Then quit ediff normally, without asking for
confirmation"
  (interactive)
  (ediff-barf-if-not-control-buffer)
  (let* ((buf-a ediff-buffer-A)
         (buf-b ediff-buffer-B)
         (buf-c ediff-buffer-C)
         (ctl-buf (current-buffer))
         (modified (remove-if-not 'buffer-modified-p
                                  (list buf-a buf-b buf-c))))
    (let ((save (if modified (yes-or-no-p "Save changes?")nil)))
      (loop for buf in modified do
            (progn
              (set-buffer buf)
              (if save
                  (save-buffer)
                (set-buffer-modified-p nil))))
      (set-buffer ctl-buf)
      (ediff-really-quit nil))))

(defun sort-lines-by-length (reverse beg end)
  "Sort lines by length."
  (interactive "P\nr")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (let ;; To make `end-of-line' and etc. to ignore fields.
          ((inhibit-field-text-motion t))
        (sort-subr reverse 'forward-line 'end-of-line nil nil
                   (lambda (l1 l2)
                     (apply #'< (mapcar (lambda (range) (- (cdr range) (car range)))
                                        (list l1 l2)))))))))

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

;;;###autoload
(defun my-move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))

;;;###autoload
(defun my-move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

;; https://www.emacswiki.org/emacs/DiredOmitMode
;; omit directory entries and DS_Store
(require 'dired-x)
(setq-default dired-omit-files-p t) ; Buffer-local variable
(setq dired-omit-files "^\\.+$\\|^\\.DS_Store")
