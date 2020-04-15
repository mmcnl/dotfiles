;; follow end of compilation buffer http://stackoverflow.com/q/4657142/1163042
(setq compilation-scroll-output 'first-error)

(defun clear-previous-comint-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1))
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer))
  (switch-to-buffer (other-buffer (current-buffer) 1))
  )
(setq comint-prompt-read-only t)
