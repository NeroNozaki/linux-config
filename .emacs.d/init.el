;; -*- lexical-binding: t; -*-

(require 'use-package-ensure) ;; Load use-package-always-ensure
(setq use-package-always-ensure t) ;; Always ensures that a package is installed

;; Sync Emacs exec-path actual shell PATH
(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x pgtk))  ;; GUI Emacs
    (exec-path-from-shell-initialize)))

;; Any add to list for package-archives (to add marmalade or melpa) goes here
(require 'package)
(add-to-list 'package-archives 
    '("MELPA" .
      "http://melpa.org/packages/"))
(package-initialize)

;; Put all backups in one place
(defvar backup-dir (expand-file-name "backups/" user-emacs-directory))
(unless (file-exists-p backup-dir)
  (make-directory backup-dir t))
(setq backup-directory-alist
      `(("." . ,backup-dir)))

;; Speed
(use-package async
  :defer
  :custom
  (dired-async-mode t)
  (async-bytecomp-package-mode t)
  (async-bytecomp-allowed-packages '(all))
  (async-package-do-action t))
(setq package-quickstart t)

;; impatient mode
(use-package impatient-mode)
(add-hook 'html-mode-hook 'impatient-mode)
(add-hook 'css-mode-hook 'impatient-mode)
(add-hook 'js2-mode-hook 'impatient-mode)

;; QoL changes
(cua-mode nil)
(cua-mode -1)
(setq debug-on-error t)
(setq wdired-allow-to-change-permissions t)
(setq-default display-line-numbers-type 'relative)
    (use-package emacs
      :custom
      (dired-kill-when-opening-new-dired-buffer nil)

      (global-display-line-numbers-mode t)
      (display-line-numbers-type 'relative)
      (global-hl-line-mode nil)

      (native-comp-async-report-warnings-errors 'silent)
      (warning-minimum-level :error)

      (scroll-conservatively 10) ;; Smooth scrolling
      (scroll-margin 5)

      (pixel-scroll-precision-mode t) ;; Precise pixel scrolling. i.e. smooth scrolling (GUI only)
      (pixel-scroll-precision-use-momentum nil)

      (indent-tabs-mode nil) ;; Only use spaces for indentation
      (tab-width 4)
      (sgml-basic-offset 4) ;; Set Html mode indentation to 4

      (delete-by-moving-to-trash t)
      :config
      ;; Move customization variables to a separate file and load it, avoid filling up init.el with unnecessary variables
      ;;(setq custom-file (locate-user-emacs-file "custom-vars.el"))
      ;;(load custom-file 'noerror 'nomessage)
      )

;; folding
(use-package kirigami
  :commands (kirigami-open-fold
             kirigami-open-fold-rec
             kirigami-close-fold
             kirigami-toggle-fold
             kirigami-open-folds
             kirigami-close-folds-except-current
             kirigami-close-folds))

;; Getting rid of line numbers in certain modes
(dolist (mode '(eat-mode-hook)
	      )
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(doom-modeline-mode)
(display-battery-mode)
(setq doom-modeline-battery t)
(savehist-mode 1)
(setq-default fill-column 130)

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(require 'package)
(use-package org-superstar)
(use-package org-modern)
(use-package org-appear)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(add-hook 'org-mode-hook #'auto-fill-mode)
(add-hook 'org-mode-hook #'visual-line-mode)

(use-package markdown-mode)

;; Prevent Customize from writing to ~/.emacs
(setq custom-file (expand-file-name ".emacs.custom.el" user-emacs-directory))

;; Load the custom file if it exists
(when (file-exists-p custom-file)
  (load custom-file 'noerror 'nomessage))

;; find config.el or config.org
(defun my/load-config (name)
  (let* ((el-file  (expand-file-name (concat name ".el")  user-emacs-directory))
         (org-file (expand-file-name (concat name ".org") user-emacs-directory)))
    
    ;; Check if config.el exists, if not, tangle config.org to produce config.el
    (unless (file-exists-p el-file)
      (when (file-exists-p org-file)
        (require 'org)
        (org-babel-tangle-file org-file el-file)
        (message "Tangling %s → %s" org-file el-file)))

    ;; Actually load the config
    (if (file-exists-p el-file)
        (progn
          (load el-file nil 'nomessage)
          (message "Loaded config: %s" name))
      (message "WARNING: Config %s.el not found (and no %s.org to tangle)" name name))))

(my/load-config "my-evil-config")
