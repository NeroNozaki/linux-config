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

(provide 'my-functions)
