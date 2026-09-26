;;; c-highlight.el --- Custom tree-sitter highlighting for C# -*- lexical-binding: t; -*-

(defvar c3-highlight-features ())

(defun c3-ts-highlight ()
  "Custom tree-sitter highlighting for C3."
  (when (derived-mode-p 'c3-ts-mode)
    (let* ((rules
            (treesit-font-lock-rules
             :language 'c3
             :override 'prepend
             :feature 'c3-char-literal
             '((char_literal "'")        @font-lock-string-face)
             
             :language 'c3
             :override 'prepend
             :feature 'c3-char-literal
             '((char_literal (escape_sequence)) @font-lock-string-face)

             :language 'c3
             :override 'prepend
             :feature 'c3-functions
             '((func_header name: (ident) @semantic-function-declaration-face)
               )

             ;; :language 'c3
             ;; :override t
             ;; :feature 'c3-functions
             ;; '(((call_expression
             ;;    function: (identifier) @semantic-default-library)
             ;;   (:match "\\`\\(printf\\|scanf\\|fprintf\\)\\`" @semantic-default-library)))

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
        (add-to-list 'c3-highlight-features feat))

      (treesit-font-lock-recompute-features)
      (font-lock-flush)
      (font-lock-ensure))))


(add-hook 'c3-ts-mode-hook #'c3-ts-highlight)
(provide 'c3-highlight)
;;; c3-highlight.el ends here
