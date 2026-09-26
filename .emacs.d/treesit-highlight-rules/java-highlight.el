;;; java-highlight.el --- Custom tree-sitter highlighting for Java -*- lexical-binding: t; -*-

(defvar java-highlight-features ())

(defun java-ts-highlight ()
  "Custom tree-sitter highlighting for Java."
  (when (derived-mode-p 'java-ts-mode)
    (let* ((rules
            (treesit-font-lock-rules
             :language 'java
             :override 'append
             :feature 'java-attributes
             '((field_access
                field: (identifier) @semantic-attribute-face))

             :language 'java
             :override 'append
             :feature 'java-methods
             '((method_invocation
                name: (identifier) @semantic-method-face))))

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
        (add-to-list 'java-highlight-features feat))

      (treesit-font-lock-recompute-features)
      (font-lock-flush)
      (font-lock-ensure))))

(add-hook 'java-ts-mode-hook #'java-ts-highlight)
(provide 'java-highlight)
;;; java-highlight.el ends here
