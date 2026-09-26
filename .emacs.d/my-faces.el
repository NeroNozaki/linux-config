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
 'c-ts-mode
 '(("\\_<[0-9]+\\_>" . 'math-number-face)))


(defface semantic-attribute-face
  '((t :inherit default))
  "face for attributes. fields of a class or struct.")
(defface semantic-method-face
  '((t :inherit default))
  "face for methods. functions of a class or struct.")
(defface semantic-function-face
  '((t :inherit default))
  "face for functions.")
(defface semantic-function-declaration-face
  '((t :inherit semantic-function-face))
  "face for function declarations.")
(defface semantic-default-library
  '((t :inherit default))
  "face for default/built in functions.")

(provide 'my-faces)
