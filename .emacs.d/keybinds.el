;;; keybinds.el --- file for keybinds -*- lexical-binding: t; -*-

;; Evil mode set up
(use-package evil-mc
  :ensure t)

(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-i-jump nil
        evil-vsplit-window-right t
        evil-split-window-below t)

  :custom
  (evil-undo-system 'undo-redo) ;; C-r to redo
  (evil-want-fine-undo t)

  :config
  ;; Enable Evil
  (evil-mode 1)

  ;; General Evil behavior
  (setq evil-move-cursor-back nil
        evil-move-beyond-eol nil)

  ;; Motion state
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil)
  (evil-global-set-key 'motion "j" #'evil-next-visual-line)
  (evil-global-set-key 'motion "k" #'evil-previous-visual-line)
  (define-key evil-motion-state-map (kbd "0") #'evil-first-non-blank)
  (define-key dired-mode-map (kbd "n") nil)
  (evil-define-key 'normal eat-mode-map (kbd "p") #'term-paste)

  ;; Normal state
  (evil-global-set-key 'normal "n" #'evil-search-next)

  (define-key evil-normal-state-map (kbd "zo") #'kirigami-open-fold)
  (define-key evil-normal-state-map (kbd "zO") #'kirigami-open-fold-rec)
  (define-key evil-normal-state-map (kbd "zc") #'kirigami-close-fold)
  (define-key evil-normal-state-map (kbd "za") #'kirigami-toggle-fold)
  (define-key evil-normal-state-map (kbd "zr") #'kirigami-open-folds)
  (define-key evil-normal-state-map (kbd "zm") #'kirigami-close-folds)

  ;; Insert state
  (define-key evil-insert-state-map (kbd "C-g") #'evil-normal-state)

  ;; Global
  (global-set-key [C-backspace] #'evil-delete-backward-word)) ;; make C-backspace less aggressive

(use-package evil-goggles
  :init (evil-goggles-mode)
  :custom (evil-goggles-duration 0.08)
  )

(use-package evil-collection
  :after evil
  :ensure t
  :init
  (evil-collection-init)
  :config
  ;; Setting where to use evil-collection)
  ;; (setq evil-collection-mode-list '(dired ibuffer magit corfu consult info (package-menu package) bookmark))
  )

;; i'm pretty sure this is unnecessary so i commented it out
;; (evil-ex-define-cmd "t" '(lambda() (interactive) (split-window-below) (other-window 1) (eat)))

;; General.el / leader key definition
;; ==================== LEADER KEY (right Alt = ¥) ====================
(global-unset-key (kbd "¥"))
(use-package general
  :ensure t
  :config
  (general-create-definer leader
    :states '(normal visual motion emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "SPC")
  ;; ←←← COMMANDS GO HERE ←←←
  (leader
    "f"     'find-file
    "b"     'consult-buffer
    "s"     'save-buffer
    "k"     'kill-this-buffer
    "SPC"   'execute-extended-command

    ;; magit
    "g"     'magit-status
    "ef"    'with-editor-finish

    "eb"    'eval-buffer
    "ep"    'eval-print-last-sexp

    ;; help
    "hf"    'describe-function
    "hv"    'describe-variable
    "hk"    'describe-key
    "hm"    'describe-mode

    ;; window movement
    "wk"    'evil-window-up
    "wh"    'evil-window-left
    "wj"    'evil-window-down
    "wl"    'evil-window-right

    ;; yasnippets
    "yi"    'yas-insert-snippet
    "yv"    'yas-visit-snippet-file
    "yn"    'yas-new-snippet

    "c"     'compile
    "t"     #'my/eat
    "v"     'evil-window-vsplit
    "0"     'delete-window
    "1"     'delete-other-windows
    "¥"     'keyboard-quit
    "ESC"   'keyboard-quit
    ))

;; global rebinds
(add-to-list 'load-path "~/.emacs.d/elpa/zoom-frm-manual/")
(require 'zoom-frm) 
(global-unset-key (kbd "C--"))
(with-eval-after-load 'elisp-mode
  (define-key emacs-lisp-mode-map (kbd "C-c C-c") #'eval-buffer))
(global-set-key (kbd "C--")       'zoom-in/out)
(global-set-key (kbd "C-=")       'zoom-in/out)
(global-set-key (kbd "C-x C-'")   'comment-or-uncomment-region)

(with-eval-after-load 'dired-mode
  (define-key dired-mode-map (kbd "* $") #'dired-kill-subdir))

;; Separating tab from C-i
(define-key input-decode-map [(control ?i)] [control-i])
(define-key input-decode-map [(control ?I)] [(shift control-i)])

(provide 'keybinds)
