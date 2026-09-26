;;; zig-highlight.el --- Custom tree-sitter highlighting for Zig -*- lexical-binding: t; -*-

(defvar zig-highlight-features ())

(defun zig-ts-highlight ()
  "Custom tree-sitter highlighting for Zig."
  (when (derived-mode-p 'zig-ts-mode)
    (let* ((rules
            (treesit-font-lock-rules
             :language 'zig
             :override 'append
             :feature 'zig-functions
             '((variable_type_function: (IDENTIFIER) @semantic-function-face)
               
               )

             )


            )

           ;; Automatically collect the feature symbols from the rules
           (features
            (mapcar (lambda (setting) (nth 2 setting)) rules)))

      ;; 1. Add the rules
      (setq-local treesit-font-lock-settings
                  (append treesit-font-lock-settings rules))

      ;; 2. Enable the features (derived automatically)
      (let ((fl treesit-font-lock-feature-list))
        (while (< (length fl) 4)
          (setq fl (append fl (list nil))))
        (dolist (feat features)
          (cl-pushnew feat (nth 3 fl)))
        (setq-local treesit-font-lock-feature-list fl))

      ;; 3. Optional: also keep a global list if you still want it
      (dolist (feat features)
        (add-to-list 'zig-highlight-features feat))

      (treesit-font-lock-recompute-features)
      (font-lock-flush)
      (font-lock-ensure))))

(add-hook 'zig-mode-hook #'zig-ts-highlight)
(provide 'zig-highlight)
;;; zig-highlight.el ends here
