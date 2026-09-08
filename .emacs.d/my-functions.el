;;; my-functions.el --- file for storing custom functions so they don't eat up my config  -*- lexical-binding: t; -*-

(defun my/write-to-file ()
  (interactive)
  (write-region (point-min) (point-max) (read-file-name "Save buffer contents to: ")))

(provide 'my-functions)
