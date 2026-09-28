;;; treesit-highlight.el --- Load all custom tree-sitter highlight rules -*- lexical-binding: t; -*-
(add-to-list 'load-path
             (expand-file-name "treesit-highlight-rules" user-emacs-directory))

;; list of all features to load
(defvar treesit-highlight-features nil
  "all custom tree-sitter features from every language")

;; require
(require 'java-highlight)
(require 'c-highlight)
(require 'zig-highlight)
(require 'c3-highlight)

(defun treesit-highlight-universal ()
  "Rules that should look the same in every language."
  (treesit-font-lock-rules
   :override t

   ;; add universal features here
   ))

;; functions
(defun treesit-highlight--ensure-features (features)
  "Ensure all FEATURES (a list of symbols) are in the highest
level of `treesit-font-lock-feature-list'."
  (let ((fl treesit-font-lock-feature-list))
    (while (< (length fl) 4)
      (setq fl (append fl (list nil))))
    (dolist (feat features)
      (cl-pushnew feat (nth 3 fl)))
    (setq-local treesit-font-lock-feature-list fl)))

(defun treesit-highlight-apply-universal ()
  "Apply universal rules + ensure features are enabled."
  (when (treesit-parser-list)
    (setq-local treesit-font-lock-settings
                (append treesit-font-lock-settings
                        (treesit-highlight-universal)))
    ;; Enable whatever features the universal rules use
    (treesit-highlight--ensure-features treesit-highlight-features)
    (treesit-font-lock-recompute-features)
    (font-lock-flush)))

(defun treesit-highlight-reload ()
  "Force a complete reload of custom tree-sitter highlighting
without destroying the mode's original rules."
  (interactive)
  (when (treesit-parser-list)
    ;; Re-apply universal rules (they just append)
    (treesit-highlight-apply-universal)

    ;; Re-apply language-specific rules
    (when (derived-mode-p 'java-ts-mode)
      (java-ts-highlight))

    (treesit-font-lock-recompute-features)
    (font-lock-flush)
    (font-lock-ensure)
    (message "Tree-sitter highlighting reloaded")))

;; Add the hook here, after the function is defined
(add-hook 'prog-mode-hook #'treesit-highlight-apply-universal)

(provide 'treesit-highlight)
;;; treesit-highlight.el ends here
