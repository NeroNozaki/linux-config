;;; faces.el --- file for adding faces so they don't eat up my config  -*- lexical-binding: t; -*-
(message "MY FACES EL IS BEING LOADED")

(message "ABOUT TO DEFINE math-number-face")
(defface math-number-face
  '((t (:inherit default)))
  "Face for numbers")
(message "DEFINED math-number-face: %s"
         (facep 'math-number-face))

(font-lock-add-keywords
 'js2-mode
 '(("[0-9]+\\(\\.[0-9]+\\)?" . 'math-number-face)))

(font-lock-add-keywords
 'python-mode
 '(("[0-9]+\\(\\.[0-9]+\\)?" . 'math-number-face)))

(font-lock-add-keywords
 'python
 '(("[0-9]+\\(\\.[0-9]+\\)?" . 'math-number-face)))

(font-lock-add-keywords
 'java-mode
 '(("\\_<[0-9]+\\_>" . 'math-number-face)))

(font-lock-add-keywords
 'c-mode
 '(("\\_<[0-9]+\\_>" . 'math-number-face)))


(provide 'my-faces)
