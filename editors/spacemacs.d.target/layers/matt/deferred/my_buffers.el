(global-set-key [(control tab)]  'mybuffers-switch)

(defvar mybuffers-repetitions 0
  "Number of times `mybuffers-switch' was repeated.")

(defvar mybuffers-list ()
  "List of non-special buffers open.")

(defun mybuffers-switch ()
  "Switch to buffer in my buffer list.
You should bind this function to Ctrl-Tab or something."
  (interactive)
  ;; if the last command wasn't a switch buffer, reset
  (when (not (eq last-command 'mybuffers-switch))
    (setq mybuffers-repetitions 0
          mybuffers-list (mybuffers-filter-buffers 'mybuffers-normal-buffer-p)))
  ;; if the current buffer is not a special buffer
  (when (not (mybuffers-special-buffer-p (current-buffer)))
    (setq mybuffers-repetitions (1+ mybuffers-repetitions))
    ;; swap or rotate
    (if (< mybuffers-repetitions (length mybuffers-list))
        (setq mybuffers-list (mybuffers-swap mybuffers-list 0 mybuffers-repetitions))
      (setq mybuffers-list (mybuffers-rotate mybuffers-list))
      (setq mybuffers-repetitions 0)))
  ;; switch to 1st buffer
  (switch-to-buffer (elt mybuffers-list 0))
  (mybuffers-reorder-buffer-list
   (append mybuffers-list
           (mybuffers-filter-buffers 'mybuffers-special-buffer-p))))

(defun mybuffers-filter-buffers (filter-function)
  "Returns a list of buffers that match FILTER-FUNCTION."
  (delq nil
        (mapcar (lambda (buffer)
                  (if (funcall filter-function buffer) buffer nil))
                (buffer-list))))

(defun mybuffers-special-buffer-p (buffer)
  "Returns t if BUFFER is one of the special buffers, `nil' otherwise.
A special buffer is one whose name starts with an asterisk. And a
few others listed here."
  (let ((name (buffer-name buffer)))
    (and (not (whitelist-buffer-p buffer))
         (or (string-match "^ ?\\*" name)
             (string-match "ein:mlf-fontification" name)
             (equal "TAGS" name)
             ))))

(defun whitelist-buffer-p (buffer)
  "Returns t if BUFFER is one of the whitelisted buffers, `nil' otherwise."
  (let ((name (buffer-name buffer)))
    (or (string-match "ein:notebooklist 88" name)
        (string-match "ein: 88" name)
        )))

(defun mybuffers-normal-buffer-p (buffer)
  "This is the complement of `mybuffers-special-buffer-p'."
  (not (mybuffers-special-buffer-p buffer)))

(defun mybuffers-reorder-buffer-list (new-list)
  "Reorder buffer list using NEW-LIST."
  (while new-list
    (bury-buffer (car new-list))
    (setq new-list (cdr new-list))))

(defun mybuffers-swap (the-list i j)
  "Swap I and J elements in THE-LIST."
  (let ((tmp (nth j the-list))
        (vec (vconcat the-list)))
    (aset vec i tmp)
    (aset vec j (nth i the-list))
    (append vec nil)))

(defun mybuffers-rotate (the-list)
  "Delete first elem in THE-LIST and append it to the end."
  (append (cdr the-list) (list (car the-list))))
