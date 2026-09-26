;;; c-highlight.el --- Custom tree-sitter highlighting for C -*- lexical-binding: t; -*-

(defvar c-highlight-features ())

(defun c-ts-highlight ()
  "Custom tree-sitter highlighting for C."
  (when (derived-mode-p 'c-ts-mode)
    (let* ((rules
            (treesit-font-lock-rules
             :language 'c
             :override 'prepend
             :feature 'c-char-literal
             '((char_literal "'")        @font-lock-string-face)
             
             :language 'c
             :override 'prepend
             :feature 'c-char-literal
             '((char_literal (character)) @font-lock-string-face)

             :language 'c
             :override 'prepend
             :feature 'c-functions
             '((function_declarator declarator: (identifier) @semantic-function-declaration-face)
               (call_expression function: (identifier) @semantic-function-face))

             :language 'c
             :override t
             :feature 'c-functions
             '(((call_expression
                function: (identifier) @semantic-default-library)
               (:match "\\`\\(printf\\|scanf\\|fprintf\\)\\`" @semantic-default-library)))

             )
            

            )

           ;; Automatically collect the feature symbols from the rules
           (features
            (mapcar (lambda (setting) (nth 2 setting)) rules)))

      ;;Add the rules
      (setq-local treesit-font-lock-settings
                  (append treesit-font-lock-settings rules))

      ;; Enable the features
      (let ((fl treesit-font-lock-feature-list))
        (while (< (length fl) 4)
          (setq fl (append fl (list nil))))
        (dolist (feat features)
          (cl-pushnew feat (nth 3 fl)))
        (setq-local treesit-font-lock-feature-list fl))

      (dolist (feat features)
        (add-to-list 'c-highlight-features feat))

      (treesit-font-lock-recompute-features)
      (font-lock-flush)
      (font-lock-ensure))))


(add-hook 'c-ts-mode-hook #'c-ts-highlight)
(provide 'c-highlight)
;;; c-highlight.el ends here
