(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "/usr/local/bin/sbcl")
;; Initialize package sources
(require 'package)

;; Add melpa package source when using package list
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

;; Uncomment following lines to set up emacs with GUI functionality (uses python and vue)
(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/")
;;(require 'eaf)
;;(require 'eaf-browser)
;;(setq eaf-python-command "/usr/local/bin/python3")

(package-initialize)			;
;;(add-to-list 'package-archives ' t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("da186cce19b5aed3f6a2316845583dbee76aea9255ea0da857d1c058ff003546" "234dbb732ef054b109a9e5ee5b499632c63cc24f7c2383a849815dacc1727cb6" "fe1c13d75398b1c8fd7fdd1241a55c286b86c3e4ce513c4292d01383de152cb7" default))
 '(package-selected-packages
   '(paredit csv-mode yaml-mode org-bullets org-pomodoro sound-wav typescript-mode evil doom-themes helpful ivy-rich which-key rainbow-delimiters rainbow-delimeters doom-modeline counsel swiper ivy command-log-mode use-package moe-theme dracula-theme ##)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;; Turn on dracula
(load-theme 'dracula t)

;;customize theme
;; If you want to use powerline, (require 'powerline) must be
;; before (require 'moe-theme).
(add-to-list 'load-path "~/.emacs.d/PATH/TO/powerline/")
(require 'powerline)

;; Moe-theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/moe-theme-1.0.1")
(add-to-list 'load-path "~/.emacs.d/elpa/moe-theme-1.0.1")
(require 'moe-theme)

;; Show highlighted buffer-id as decoration. (Default: nil)
(setq moe-theme-highlight-buffer-id t)

;; Resize titles (optional).
(setq moe-theme-resize-markdown-title '(1.5 1.4 1.3 1.2 1.0 1.0))
(setq moe-theme-resize-org-title '(1.5 1.4 1.3 1.2 1.1 1.0 1.0 1.0 1.0))
(setq moe-theme-resize-rst-title '(1.5 1.4 1.3 1.2 1.1 1.0))

;; Choose a color for mode-line.(Default: blue)
;;(moe-theme-set-color 'green)

;; Finally, apply moe-theme now.
;; Choose what you like, (moe-light) or (moe-dark)
(moe-dark)

(column-number-mode)
(global-display-line-numbers-mode t)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(setq inhibit-startup-message t)

(scroll-bar-mode -1) ;; Disable visible scroball
(tool-bar-mode -1) ;; Disable toolbar
(set-fringe-mode 10)

;(unless package-archive-contents
(package-refresh-contents)

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package command-log-mode)
(use-package counsel)

(use-package ivy
  :diminish
  :bind (("\C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package swiper :ensure t)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 10)))
(setq find-file-visit-truename t)

(use-package doom-themes)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
  
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)) ;; Don't start searches with ^

(use-package helpful
  :ensure t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))
(put 'erase-buffer 'disabled nil)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)
(put 'narrow-to-region 'disabled nil)

(global-set-key "\C-cw" 'compare-windows)
(global-unset-key "\C-xf")


(defun andy/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-indent nil))

(use-package org
  :hook (org-mode . andy/org-mode-setup)
  :config
  (setq org-ellipsis " ⤵"
	org-hide-mphasis-markers t))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("•" "◦" "▸" "▹")))

(setq-default frame-title-format "%b (%f)")

(add-hook 'lisp-mode-hook (lambda () (paredit-mode +1))) 


(require 'yaml-mode)
(require 'paredit)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(display-time)

;; Use y or n instead of yes or not
(fset 'yes-or-no-p 'y-or-n-p)


;;-----------------------
;; Use paredit in the minibuffer -->http://emacsredux.com/blog/2013/04/18/evaluate-emacs-lisp-in-the-minibuffer
;;-----------------------
(add-hook 'minibufffer-setup-hook 'conditionally-enable-paredit-mode)
(defvar paredit-minibuffer-commands '(eval-expression
                     pp-eval-expression
                     eval-expression-with-eldoc
                     ibuffer-do-eval
                     ibuffer-do-view-and-eval)
"Interactive commands for which paredit should be enabled in the minibuffer.")
(defun conditionally-enable-paredit-mode ()
  "Enable paredit during lisp related minibuffer commands."
  (if (memq this-command paredit-minibuffer-commands)
      (enable-paredit-mode)))
;;------------------------
;; Add paredit to ...
;;------------------------
(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
;;--------------------------------
;; Enable some handy paredit functions in all prog modes. REM to get it!
;;--------------------------------
(require 'paredit-everywhere)
(add-hook 'prog-mode-hook 'paredit-everywhere-mode)
(add-hook 'css-mode-hook 'paredit-everywhere-mode)

;; REMEMBER sync name/provide statment this setup/init file's when done
(provide 'txe-paredit-init)
