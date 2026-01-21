;;; init.el --- Robust Python & Evil Configuration -*- lexical-binding: t; -*-

;; Disable package.el completely
(setq package-enable-at-startup nil)

;; ----------------------------------------
;; 0. Manual Path Injection (Fixes "failed to run git")
;; ----------------------------------------
(let ((homebrew-path "/opt/homebrew/bin"))
  (when (and (eq system-type 'darwin)
             (file-directory-p homebrew-path))
    (add-to-list 'exec-path homebrew-path)
    (setenv "PATH" (concat homebrew-path ":" (getenv "PATH")))))

;; ----------------------------------------
;; 1. straight.el bootstrap
;; ----------------------------------------
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el"
                         user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; ----------------------------------------
;; 2. Environment & use-package setup
;; ----------------------------------------
(when (memq window-system '(mac ns x))
  (straight-use-package 'exec-path-from-shell)
  (exec-path-from-shell-initialize))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t
      use-package-always-defer t)
(require 'use-package)

;; ----------------------------------------
;; 3. Custom File
;; ----------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; ----------------------------------------
;; 4. Core UI
;; ----------------------------------------
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(set-fringe-mode 10)
(column-number-mode)
(global-display-line-numbers-mode t)

;; ----------------------------------------
;; 5. Theme & Modeline
;; ----------------------------------------
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t doom-themes-enable-italic t)
  (load-theme 'doom-molokai t)
  (doom-themes-org-config))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :custom (doom-modeline-height 15))

;; ----------------------------------------
;; 6. Evil (Vim emulation)
;; ----------------------------------------
(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-u-scroll t
        evil-want-C-i-jump nil)
  :hook (emacs-startup . evil-mode)
  :config
  (evil-mode 1)
  (dolist (mode '(term-mode eshell-mode shell-mode vterm-mode))
    (add-to-list 'evil-emacs-state-modes mode)))

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :init (which-key-mode)
  :config
  (setq which-key-idle-delay 0.3
        which-key-show-early-on-C-h t))

;; ----------------------------------------
;; 7. Completion & Navigation (Ivy)
;; ----------------------------------------
(use-package ivy
  :diminish
  :init (ivy-mode 1)
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line))
  :config
  (setq ivy-use-virtual-buffers t
        enable-recursive-minibuffers t))

(use-package counsel
  :after ivy
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-x b" . counsel-ibuffer)))

(use-package swiper :after ivy)

;; ----------------------------------------
;; 8. Project & Git
;; ----------------------------------------
(use-package projectile
  :diminish projectile-mode
  :config
  (projectile-mode +1)
  (setq projectile-completion-system 'ivy)
  :bind-keymap ("C-c p" . projectile-command-map))

(straight-use-package '(llama :type git :host github :repo "tarsius/llama"))
(use-package magit
  :straight (:host github :repo "magit/magit")
  :bind (("C-x g" . magit-status)))

(use-package treemacs
  :defer t
  :bind (("C-c t" . treemacs)))

(use-package treemacs-projectile :after (treemacs projectile))
(use-package treemacs-evil :after (treemacs evil))
(use-package all-the-icons :if (display-graphic-p))

;; ----------------------------------------
;; 9. Org Mode
;; ----------------------------------------
(use-package org
  :pin gnu
  :config
  (setq org-startup-indented t
        org-hide-leading-stars t
        org-agenda-files '("~/org")))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))

;; ----------------------------------------
;; 10. Python Development Module (The Big One)
;; ----------------------------------------

;; Virtual Environment Management
(use-package pyvenv
  :config
  (pyvenv-mode 1))

;; LSP Client
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (python-mode . lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (setq lsp-enable-snippet t
        lsp-prefer-flymake nil))

;; Python LSP Server (Pyright)
(use-package lsp-pyright
  :hook (python-mode . (lambda () (require 'lsp-pyright) (lsp-deferred))))

(use-package lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-position 'top
        lsp-ui-sideline-enable t))

(use-package company
  :hook (after-init . global-company-mode)
  :config (setq company-idle-delay 0.1))

;; Auto-formatting
(use-package apheleia
  :config
  (apheleia-global-mode +1)
  (setf (alist-get 'python-mode apheleia-mode-alist) '(isort black)))

;; ----------------------------------------
;; 11. Vterm & Shell Toggle (Modern REPL)
;; ----------------------------------------

(use-package vterm
  :straight t)

(use-package vterm-toggle
  :straight t
  :bind (("C-c C-z" . vterm-toggle)
         :map vterm-mode-map
         ("C-c C-z" . vterm-toggle)) ;; Toggle it closed from inside vterm
  :config
  (setq vterm-toggle-fullscreen-p nil)
  ;; This ensures the terminal always pops up at the bottom
  (add-to-list 'display-buffer-alist
               '((lambda (bufname _) (with-current-buffer bufname (equal major-mode 'vterm-mode)))
                 (display-buffer-reuse-window display-buffer-at-bottom)
                 (window-height . 0.3))))

;; ----------------------------------------
;; 12. Final Python Logic & Evil Keys
;; ----------------------------------------

(setq python-shell-interpreter "python3"
      python-shell-interpreter-args "-i")

(with-eval-after-load 'python
  ;; vterm-toggle handles starting the shell and switching automatically
  (define-key python-mode-map (kbd "C-c C-z") 'vterm-toggle))

(with-eval-after-load 'evil
  (evil-define-key 'normal python-mode-map
    (kbd "g d") 'lsp-find-definition
    (kbd "g r") 'lsp-find-references
    (kbd "K")   'lsp-ui-doc-glance))

;;; init.el ends here
