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

(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (pbcopy-select-text filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

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

(defun ido-sort-mtime ()
  "sort ido filelist by mtime instead of alphabetically"
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

;; https://www.emacswiki.org/emacs/DiredOmitMode
;; omit directory entries and DS_Store
(require 'dired-x)
(setq-default dired-omit-files-p t) ; Buffer-local variable
(setq dired-omit-files "^\\.+$\\|^\\.DS_Store")

;; http://superuser.com/questions/603421/how-to-remove-smart-quotes-in-copy-paste
(defun replace-smart-quotes (beg end)
  "Replace 'smart quotes' in buffer or region with ascii quotes."
  (interactive "r")
  (format-replace-strings '(("\x201C" . "\"")
                            ("\x201D" . "\"")
                            ("\x2018" . "'")
                            ("\x2019" . "'"))
                          nil beg end))

(defun whitespace-cleanup-buffer() (interactive)(ws-butler-clean-region (point-min)(point-max)))
(defun new-empty-buffer() (interactive)(spacemacs/new-empty-buffer)(text-mode))
