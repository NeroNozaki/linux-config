;;; my-functions.el --- file for storing custom functions so they don't eat up my config  -*- lexical-binding: t; -*-

(defun my/write-to-file ()
  "Write contents of buffer to another file"
  (interactive)
  (write-region (point-min) (point-max) (read-file-name "Save buffer contents to: ")))

(defun my/use-zig ()
  "Create symlink to zlib on current directory"
  (interactive)
  (shell-command "use-zig")
  (revert-buffer))

(defun my/eat (&optional prefix)
  "Show the last Eat buffer, or create a new one with PREFIX."
  (interactive "P")
  (split-window-below)
  (other-window 1)

  (if prefix
      (let ((number 1))
        ;; Find the first unused *eat-N* name.
        (while (get-buffer (format "*eat-%d*" number))
          (setq number (1+ number)))

        ;; Make Eat use that name.
        (let ((eat-buffer-name (format "*eat-%d*" number)))
          (eat)))

    ;; No prefix: find the most recently used Eat buffer.
    (let ((buffer
           (seq-find
            (lambda (buffer)
              (with-current-buffer buffer
                (eq major-mode 'eat-mode)))
            (buffer-list))))

      (if buffer
          (switch-to-buffer buffer)
        (eat)))))

(provide 'my-functions)
