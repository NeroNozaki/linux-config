;;; keybinds.el --- file for keybinds -*- lexical-binding: t; -*-

;; Evil mode set up
(use-package evil-mc
  :ensure t)

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-i-jump nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  :custom
  (evil-undo-system 'undo-redo) ;; C-r to redo
  (evil-want-fine-undo t)
  :bind (:map evil-motion-state-map
	      ("SPC" . nil)
	      ("RET" . nil)
	      ("TAB" . nil))
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (global-set-key [C-backspace] 'evil-delete-backward-word) ;; Make C-backspace less agressive
  (setq evil-move-cursor-back nil
      evil-move-beyond-eol   nil)

  ;; Disable originals
  (evil-define-key '(normal motion) 'global
    (kbd "h") nil
    (kbd "j") nil
    (kbd "k") nil
    (kbd "l") nil
    (kbd "C-w h") nil
    (kbd "C-w j") nil
    (kbd "C-w k") nil
    (kbd "C-w l") nil
    )

  ;; i = up, j = left, k = down, o = right
  (evil-define-key 'visual 'global
    (kbd "i") 'previous-line
    (kbd "o") 'forward-char       
    )
  (evil-define-key '(normal motion) 'global
    (kbd "i") 'previous-line
    (kbd "j") 'backward-char
    (kbd "k") 'next-line
    (kbd "o") 'forward-char
    )
  (evil-define-key '(normal motion) help-mode-map
    (kbd "i") 'previous-line
    )
  
  ;; C- behavior
  (evil-define-key '(normal motion) 'global
    [control-i] 'backward-paragraph
    (kbd "C-j") 'evil-backward-word-begin
    (kbd "C-k") 'forward-paragraph
    (kbd "C-o") 'evil-forward-word-begin
    )

  ;; M- as replacement for fn behavior
  (evil-define-key '(normal motion) 'global
    (kbd "M-i") 'scroll-down-command
    (kbd "M-j") 'beginning-of-line
    (kbd "M-k") 'scroll-up-command
    (kbd "M-o") 'end-of-line
    )

  ;; Window movement
  (evil-define-key '(normal motion) 'global
    (kbd "C-w i") 'evil-window-up
    (kbd "C-w j") 'evil-window-left
    (kbd "C-w k") 'evil-window-down
    (kbd "C-w o") 'evil-window-right
    )
  
  ;; Other important keybinds
  (evil-define-key '(normal motion) 'global
    (kbd "SPC")   'evil-insert
    (kbd "S-SPC") 'evil-insert-line
    (kbd "a")     'evil-append
    (kbd "A")     'evil-append-line
    )
  (evil-define-key 'normal 'global
    (kbd "l")   'recenter-top-bottom
    (kbd "h")   'evil-open-below
    (kbd "H")   'evil-open-above
    )
  ) 
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
  (dolist (key '("i" "j" "k" "o" "h" "l" "SPC"))
    (evil-define-key '(normal motion) dired-mode-map (kbd key) nil)
    (evil-define-key '(normal motion) help-mode-map (kbd key) nil)
    (evil-define-key '(normal motion) package-menu-mode-map (kbd key) nil)
    (evil-define-key '(normal motion) eat-mode (kbd key) nil)
    (evil-define-key '(normal motion) custom-mode (kbd key) nil)
    (evil-define-key '(normal motion) info-mode (kbd key) nil)
    )
  (evil-define-key '(normal motion) dired-mode-map
    (kbd "SPC") 'dired-toggle-read-only
    (kbd "i")   'dired-previous-line
    (kbd "k")   'dired-next-line
    )
  (evil-define-key '(normal motion) org-mode-map
    [control-i] 'backward-paragraph
    (kbd "C-j") 'backward-word
    (kbd "C-k") 'forward-paragraph
    (kbd "C-o") 'forward-word
    (kbd "M-i") 'scroll-down-command
    (kbd "M-j") 'beginning-of-line
    (kbd "M-k") 'scroll-up-command
    (kbd "M-o") 'end-of-line
    )
  (evil-define-key '(normal motion) help-mode-map
    (kbd "i")   'previous-line
    (kbd "C-o") 'forward-word
    )
  (evil-define-key '(normal motion) package-menu-mode-map
    (kbd "i") 'previous-line
    (kbd "SPC")   'evil-insert
    (kbd "S-SPC") 'evil-append
    )
  (evil-define-key '(normal motion) eat-mode-map
    (kbd "i") 'previous-line
    )
  (evil-define-key '(normal motion) custom-mode-map
    (kbd "i") 'previous-line
    )
  (evil-define-key '(normal motion) info-mode-map
    (kbd "i") 'previous-line
    )
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
    :states '(normal insert visual motion emacs)
    :keymaps 'override
    :prefix "¥"
    :global-prefix "¥")
  ;; ←←← ADD YOUR COMMANDS HERE ←←←
  (leader
    "f"     'find-file
    "b"     'consult-buffer
    "s"     'save-buffer
    "k"     'kill-this-buffer
    "SPC"   'execute-extended-command
    "g"     'magit-status

    "eb"    'eval-buffer

    ;; help
    "hf"    'describe-function
    "hv"    'describe-variable
    "hk"    'describe-key

    ;; window movement
    "wi"    'evil-window-up
    "wj"    'evil-window-left
    "wk"    'evil-window-down
    "wo"    'evil-window-right

    ;; yasnippets
    "yi"    'yas-insert-snippet
    "yv"    'yas-visit-snippet-file
    "yn"    'yas-new-snippet

    "t"     '(lambda () (interactive) (split-window-below) (other-window 1) (eat))
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
(global-set-key (kbd "C-z")       'suspend-emacs)
(global-set-key (kbd "C-x C-'")   'comment-or-uncomment-region)

(provide 'keybinds)
