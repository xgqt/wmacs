;;; init --- initialization
;;; Commentary:
;;  delete ~/.emacs file
;;  place this file in
;;  ~/.emacs.d directory
;;; Code:

;; Vscode? Pfff... ;-) Watch this...


;; --- Basic ---

;; Set path to store "custom-set"
(setq custom-file "~/.emacs.d/emacs-custom.el")

;; Edit configuration
(defun config-visit ()
  "Edit config.org."
  (interactive)
  (find-file "~/.emacs.d/init.el" )
  )
(global-set-key (kbd "C-c e") 'config-visit)

;; Reload configuration
(defun config-reload ()
  "Reload config.org at runtime."
  (interactive)
  (when (file-readable-p "~/.emacs.d/init.el")
    (load-file (expand-file-name "~/.emacs.d/init.el" ))
    )
  )
(global-set-key (kbd "C-c r") 'config-reload)


;;; --- Packages ---

;; package archives
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives
      '(
        ("ELPA"  . "http://tromey.com/elpa/")
        ("gnu"   . "http://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("ORG"   . "https://orgmode.org/elpa/")
        )
      )
(package-initialize)

;; Install 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  )

;; Configure package updates
(use-package auto-package-update
  :ensure t
  :config
  (setq
   auto-package-update-delete-old-verions t
   auto-package-update-interval 5
   )
  (auto-package-update-maybe)
  )


;;; --- Look & Feel ---

;; no toolbar:
(tool-bar-mode -1)

;; line numbers:
(global-display-line-numbers-mode 1)

;; scrolling:
(setq scroll-conservatively 100)

;; no "bell" (audible notification):
(setq ring-bell-function 'ignore)

;; highlight:
(global-hl-line-mode 1)

;; auto reloading (reverting) buffers
(global-auto-revert-mode 1)

;; disable lock files:
(setq create-lockfiles nil)

;; disable autosave:
(setq auto-save-default nil)

;; disable backups:
(setq make-backup-files nil)

;; Pass "y or n" instead of "yes or no"
(defalias 'yes-or-no-p 'y-or-n-p)

;; Highlight parens
(show-paren-mode 1)

;; C U A
(cua-mode 1)

;; Font
(set-face-attribute
 'default nil
 :font "JetBrains Mono"
 :height 95
 :weight 'normal
 :width 'normal
 )

;; Theme
(use-package vscode-dark-plus-theme
  :ensure t
  :init
  (load-theme 'vscode-dark-plus t)
  )

;; Candy
(global-prettify-symbols-mode 1)

;; Modeline
(column-number-mode 1)
(size-indication-mode 1)

;; Hide minor modes
(use-package diminish
  :ensure t
  )

;; Centaur Tabs
(use-package centaur-tabs
  :ensure t
  :config
  (setq
   centaur-tabs-adjust-buffer-order t
   centaur-tabs-enable-key-bindings t
   centaur-tabs-height 32
   centaur-tabs-set-bar 'over
   centaur-tabs-set-icons nil
   centaur-tabs-set-modified-marker nil
   centaur-tabs-show-navigation-buttons nil
   centaur-tabs-style "box"
   x-underline-at-descent-line t
   )
  (centaur-tabs-enable-buffer-reordering)
  (centaur-tabs-headline-match)
  (centaur-tabs-mode 1)
  )


;;; --- Buffers & Movement ---

(use-package smex
  :ensure t
  :init
  (smex-initialize)
  :bind
  ("M-x" . smex)
  )

(setq
 ido-create-new-buffer 'always
 ido-enable-flex-matching nil
 ido-everywhere t
 )
(ido-mode 1)

(use-package ido-vertical-mode
  :ensure t
  :init
  (ido-vertical-mode 1)
  (setq ido-vertical-define-keys 'C-n-and-C-p-only)
  )

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x b") 'ido-switch-buffer)

;; Keybinfing help
(use-package which-key
  :ensure t
  :init
  (which-key-mode 1)
  )

;; Switching
(use-package switch-window
  :ensure t
  :bind
  ([remap other-window] . switch-window)
  :config
  (setq
   switch-window-input-style 'minibuffer
   switch-window-shortcut-style 'qwerty
   switch-window-threshold 2
   )
  (setq switch-window-qwerty-shortcuts
        '( "a" "s" "d" "f" "g" "h" "j" "k" "l")
        )
  )

;; Horizontal splitting
(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1)
  )
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

;; Vertical splitting
(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1)
  )
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

;; Kill & remove split
(defun kill-and-remove-split ()
  "Kill and remove split."
  (interactive)
  (kill-buffer)
  (delete-window)
  (balance-windows)
  (other-window 1)
  )
(global-set-key (kbd "C-x x") 'kill-and-remove-split)


;; Gay
(use-package rainbow-mode
  :ensure t
  :hook
  (
   (prog-mode . rainbow-mode)
   )
  )
(use-package rainbow-delimiters
  :ensure t
  :hook
  (
   (prog-mode . rainbow-delimiters-mode)
   )
  )


;;; --- Programming ---

;; Encoding
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Company
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  )

;; Git
(use-package magit
  :ensure t
  :config
  (setq
   git-commit-summary-max-length 80
   magit-push-always-verify nil
   )
  :bind
  (
   ("C-c s" . magit-status)
   ("C-c b" . magit-blame)
   )
  )

;; Projectile
(use-package projectile
  :ensure t
  :init
  (projectile-mode 1)
  :bind
  ("<f5>" . 'projectile-compile-project)
  )

;; Flycheck
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode 1)
  )

;; Code snippets
(use-package yasnippet
  :ensure t
  :hook
  (
   (
    c++-mode
    c-mode
    go-mode
    haskell-mode
    html-mode
    js-mode
    lisp-mode
    python-mode
    rust-mode
    shell-mode
    ) . yas-minor-mode
   )
  :config
  (use-package yasnippet-snippets
    :ensure t
    )
  (yas-reload-all)
  )

;; Pairs
(setq
 electric-pair-pairs
 '(
   (?\" . ?\")
   (?\( . ?\))
   (?\[ . ?\])
   (?\{ . ?\})
   )
 )
(electric-pair-mode 1)

;; Match words
(use-package idle-highlight-mode
  :ensure t
  :config
  (add-hook
   'prog-mode-hook
   (lambda ()
     (idle-highlight-mode 1)
     )
   )
  )

;; Speedbar
(global-set-key (kbd "<f6>") 'speedbar)

;; Tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq
 js-indent-level 4
 c-basic-offset 4
 css-indent-offset 4
 sh-basic-offset 4
 )

;; Dired Sidebar
(use-package dired-sidebar
  :ensure t
  :commands
  (dired-sidebar-toggle-sidebar)
  :bind
  (("C-x C-n" . dired-sidebar-toggle-sidebar))
  )

;; C & C++
(add-hook 'c-mode-hook 'company-mode)
(add-hook 'c++-mode-hook 'company-mode)

;; C#
(use-package omnisharp
  :ensure t
  :hook
  (
   (csharp-mode . omnisharp-mode)
   (omnisharp-mode . company-mode)
   (omnisharp-mode . flycheck-mode)
   )
  :config
  (add-to-list 'company-backends 'company-omnisharp)
  (setq
   c-syntactic-indentation t
   truncate-lines t
   )
  )
(use-package dotnet
  :ensure t
  :hook
  (
   (csharp-mode . dotnet-mode)
   (fsharp-mode . dotnet-mode)
   )
  )

;; Elisp
(add-hook 'emacs-lisp-mode-hook 'company-mode)

;; JS
(add-hook 'js-mode-hook 'company-mode)

;; Markdown
(use-package markdown-mode
  :ensure t
  :mode
  (
   ("README\\.md\\'" . gfm-mode)
   ("\\.md\\'" . markdown-mode)
   ("\\.markdown\\'" . markdown-mode)
   )
  :init
  (setq markdown-command "multimarkdown")
  )

;; Python
(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  :config
  (setq elpy-rpc-virtualenv-path "~/.local/")
  (when (load "flycheck" t t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode)
    )
  )

;; Shell scripting
(add-hook 'sh-mode-hook 'company-mode)

;; Web
(use-package web-mode
  :ensure t
  :mode
  (
   ("/\\(views\\|html\\|theme\\|templates\\)/.*\\.php\\'" . web-mode)
   ("\\.[agj]sp\\'" . web-mode)
   ("\\.as[cp]x\\'" . web-mode)
   ("\\.blade\\.php\\'" . web-mode)
   ("\\.djhtml\\'" . web-mode)
   ("\\.ejs\\'" . web-mode)
   ("\\.erb\\'" . web-mode)
   ("\\.html?\\'" . web-mode)
   ("\\.jsp\\'" . web-mode)
   ("\\.mustache\\'" . web-mode)
   ("\\.php\\'" . web-mode)
   ("\\.phtml\\'" . web-mode)
   ("\\.tpl\\.php\\'" . web-mode)
   ("\\.xml\\'" . web-mode)
   )
  :hook
  ((web-mode . company-mode))
  :config
  (setq
   web-mode-enable-auto-closing t
   web-mode-enable-auto-pairing t
   web-mode-enable-comment-keywords t
   web-mode-enable-current-element-highlight t
   web-mode-code-indent-offset 4
   web-mode-css-indent-offset 4
   web-mode-markup-indent-offset 4
   web-mode-block-padding 4
   web-mode-script-padding 4
   web-mode-style-padding 4
   )
  )

;; Yaml
(use-package yaml-mode
  :ensure t
  :config
  (add-hook
   'yaml-mode-hook
   (lambda ()
     (define-key yaml-mode-map "\C-m" 'newline-and-indent)
     )
   )
  )


;;; --- ORG ---

;; Tweaks
(setq
 org-src-window-setup 'current-window
 org-startup-truncated nil
 )

;; Bullets
(use-package org-bullets
  :ensure t
  )


;;; --- Misc ---

;; Uppercase
(put 'upcase-region 'disabled nil)

;; Eshell
(setq eshell-highlight-prompt t)
(defalias 'open 'find-file-other-window)
(defalias 'clean 'eshell/clear-scrollback)
(global-set-key (kbd "<f7>") 'eshell)

;; Reveal
(use-package htmlize
  :ensure t)
(use-package ox-reveal
  :ensure t
  :config
  ;; maybe add auto-installer in the future
  (setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
  )

;; Dashboard
(use-package dashboard
  :ensure t
  :init
  (setq
   dashboard-items
   '(
     (recents  . 5)
     (projects . 5)
     )
   )
  (setq
   dashboard-center-content t
   inhibit-startup-message t
   inhibit-startup-screen t
   )
  (dashboard-setup-startup-hook)
  )


;;; End
;;; init.el ends here
