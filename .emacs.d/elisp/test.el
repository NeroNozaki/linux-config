;;; test.el --- file to test elisp                   -*- lexical-binding: t; -*-

;; Copyright (C) 2026  Pretzels

;; Author: Pretzels <pretzels@TheExperiment>
;; Keywords: games,


(defun add-one (num)
  (+ 1 num))

(add-one 7)

(evil-ex-define-cmd "ep" 'eval-print-last-sexp)

(defun sum (a b)
  (+ a b))

(sum 34 35)

(when 'eval-print-last-sexp
  (message "Function was evaluated, sir!"))
