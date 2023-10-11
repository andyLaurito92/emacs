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
;; Make backup files go to another directory
(setq backup-directory-alist `(("." . "~/.saves")))

;; Uncomment following lines to set up emacs with GUI functionality (uses python and vue)
(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/")
;; (require 'eaf)
;; (require 'eaf-browser)
;; (require 'eaf-demo)
;;(setq eaf-python-command "/usr/local/bin/python3")

(package-initialize)			;
;;(add-to-list 'package-archives ' t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("b9e9ba5aeedcc5ba8be99f1cc9301f6679912910ff92fdf7980929c2fc83ab4d" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "da186cce19b5aed3f6a2316845583dbee76aea9255ea0da857d1c058ff003546" "234dbb732ef054b109a9e5ee5b499632c63cc24f7c2383a849815dacc1727cb6" "fe1c13d75398b1c8fd7fdd1241a55c286b86c3e4ce513c4292d01383de152cb7" default))
 '(package-selected-packages
   '(counsel-projectile grip-mode markdown-preview-mode markdown-preview-eww treemacs-projectile projectile projectile-codesearch projectile-ripgrep spaceline-all-the-icons all-the-icons-ivy treemacs-all-the-icons org-roam treemacs-evil treemacs dir-treeview elpy ob-ipython lsp-jedi dockerfile-mode impatient-mode markdown-mode seeing-is-believing ruby-electric ruby-test-mode company-inf-ruby inf-ruby jedi wgrep eglot-java eglot telega rainbow-identifiers visual-fill-column osx-browse exec-path-from-shell switch-window buffer-move magit projectile smart-mode-line-powerline-theme paredit csv-mode yaml-mode org-bullets org-pomodoro sound-wav typescript-mode evil doom-themes helpful ivy-rich which-key rainbow-delimiters rainbow-delimeters doom-modeline counsel swiper ivy command-log-mode use-package moe-theme dracula-theme ##))
 '(sml/mode-width (if (eq (powerline-current-separator) 'arrow) 'right 'full))
 '(sml/pos-id-separator
   '(""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " " 'display
		  (funcall
		   (intern
		    (format "powerline-%s-%s"
			    (powerline-current-separator)
			    (car powerline-default-separator-dir)))
		   'powerline-active1 'powerline-active2)))
     (:propertize " " face powerline-active2)))
 '(sml/pos-minor-modes-separator
   '(""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " " 'display
		  (funcall
		   (intern
		    (format "powerline-%s-%s"
			    (powerline-current-separator)
			    (cdr powerline-default-separator-dir)))
		   'powerline-active1 'sml/global)))
     (:propertize " " face sml/global)))
 '(sml/pre-id-separator
   '(""
     (:propertize " " face sml/global)
     (:eval
      (propertize " " 'display
		  (funcall
		   (intern
		    (format "powerline-%s-%s"
			    (powerline-current-separator)
			    (car powerline-default-separator-dir)))
		   'sml/global 'powerline-active1)))
     (:propertize " " face powerline-active1)))
 '(sml/pre-minor-modes-separator
   '(""
     (:propertize " " face powerline-active2)
     (:eval
      (propertize " " 'display
		  (funcall
		   (intern
		    (format "powerline-%s-%s"
			    (powerline-current-separator)
			    (cdr powerline-default-separator-dir)))
		   'powerline-active2 'powerline-active1)))
     (:propertize " " face powerline-active1)))
 '(sml/pre-modes-separator (propertize " " 'face 'sml/modes)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;; Turn on dracula
;(load-theme 'dracula t)

;;customize theme
;; If you want to use powerline, (require 'powerline) must be
;; before (require 'moe-theme).
;(add-to-list 'load-path "~/.emacs.d/PATH/TO/powerline/")
(require 'powerline)
(powerline-default-theme)

;; Moe-theme
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/moe-theme-1.0.1")
;; (add-to-list 'load-path "~/.emacs.d/elpa/moe-theme-1.0.1")
;; (require 'moe-theme)

;; ;; Show highlighted buffer-id as decoration. (Default: nil)
;; (setq moe-theme-highlight-buffer-id t)

;; ;; Resize titles (optional).
;; (setq moe-theme-resize-markdown-title '(1.5 1.4 1.3 1.2 1.0 1.0))
;; (setq moe-theme-resize-org-title '(1.5 1.4 1.3 1.2 1.1 1.0 1.0 1.0 1.0))
;; (setq moe-theme-resize-rst-title '(1.5 1.4 1.3 1.2 1.1 1.0))

;; ;; Choose a color for mode-line.(Default: blue)
;; ;;(moe-theme-set-color 'green)

;; ;; Finally, apply moe-theme now.
;; ;; Choose what you like, (moe-light) or (moe-dark)
;; (moe-dark)

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
  :hook (after-init . doom-modeline-mode)
  :custom ((doom-modeline-height 10)))
(setq find-file-visit-truename t)
(doom-modeline-mode 1)

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
    (load-theme 'doom-molokai t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-henna") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

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
  :ensure t
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 ("C-M-y" . counsel-yank-pop)
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

;; Set transparency
(set-frame-parameter (selected-frame) 'alpha '(93 . 50))
(add-to-list 'default-frame-alist '(alpha . (85 . 50)))

(require 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(require 'osx-browse)
(osx-browse-mode 1)

(require 'telega)

(use-package eglot :ensure t)
(add-hook 'foo-mode-hook 'eglot-ensure)
(add-to-list 'eglot-server-programs
             '(python-mode "pylsp"))

;; (setq 'jedi:server-command 
;;       '("/usr/local/bin/python3" "/Users/andylaurito/miniconda3/envs/datapractice/bin/python"))
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:complete-on-dot t)                 ; optional

(require 'wgrep)

(setq js-indent-level 2)

(setq seeing-is-believing-prefix "C-c")
(require 'seeing-is-believing)
(add-hook 'ruby-mode-hook 'seeing-is-believing)

;(autoload 'inf-ruby-minor-mode "inf-ruby" "Run an inferior Ruby process" t)
;(add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)

(setq auto-save-file-name-transforms
          `((".*" ,(concat user-emacs-directory "auto-save/") t))) 

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))


(defun my/create-scratch-file (file-extension)
  "Creates a temporary file with the FILE-EXTENSION provided"
  (interactive "sEnter file extension: ")
  (let ((temp-file (make-temp-file "" nil file-extension)))
    (find-file-other-window temp-file)))

;; (setq inf-ruby-eval-binding "(defined?(IRB.conf) && IRB.conf[:MAIN_CONTEXT] && IRB.conf[:MAIN_CONTEXT].workspace.binding) || (defined?(Pry) && Pry.toplevel_binding)")

(use-package inf-ruby
  :ensure t
  :init
  (add-hook 'ruby-mode-hook 'inf-ruby-minor-mode))

;; Setting up conda environments
(require 'conda)
;; if you want eshell support, include:
;;(conda-env-initialize-eshell)

;; if you want auto-activation (see below for details), include:
;;(conda-env-autoactivate-mode t)

;; if you want to automatically activate a conda environment on the opening of a file:
;; ;;(setq conda-env-home-directory "<path-to>/anaconda3")

;; ;;get current environment--from environment variable CONDA_DEFAULT_ENV
;; (conda-env-activate 'getenv "CONDA_DEFAULT_ENV")
;; ;;(conda-env-autoactivate-mode t)
;; (setq-default mode-line-format (cons mode-line-format '(:exec conda-env-current-name)))

;; ob-ipython integration
(require 'ob-ipython)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((ipython . t)
   ;; other languages..
   ))

(require 'ein)
(require 'ein-notebook)
;;(require 'ein-subpackages)

(use-package elpy
  :ensure t
  :init
  (elpy-enable))

(load "elpy")
;;(load "elpy-rpc")
(load "elpy-shell")
(load "elpy-profile")
(load "elpy-refactor")

;; Use the corrent virtual-env; Remember to select the proper conda env
(setq elpy-rpc-virtualenv-path 'current)
(setenv "PYTHONIOENCODING" "utf-8")
(add-to-list 'process-coding-system-alist '("python" . (utf-8 . utf-8)))
(add-to-list 'process-coding-system-alist '("elpy" . (utf-8 . utf-8)))
(add-to-list 'process-coding-system-alist '("flake8" . (utf-8 . utf-8)))

;; This config comes from here https://medium.com/@aiguofer/managing-a-python-development-environment-in-emacs-43897fd48c6a
;; (use-package elpy
;;     ;:straight t
;;     :bind
;;     (:map elpy-mode-map
;;           ("C-M-n" . elpy-nav-forward-block)
;;           ("C-M-p" . elpy-nav-backward-block))
;;     :hook ((elpy-mode . flycheck-mode)
;;            (elpy-mode . (lambda ()
;;                           (set (make-local-variable 'company-backends)
;;                                '((elpy-company-backend :with company-yasnippet))))))
;;     :init
;;     (elpy-enable)
;;     :config
;;     (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;;     ; fix for MacOS, see https://github.com/jorgenschaefer/elpy/issues/1550
;;     (setq elpy-shell-echo-output nil)
;;     ;;(setq elpy-rpc-python-command "python3")
;;     (setq elpy-rpc-timeout 2))
;; This fixes the bux ‘python-shell-interpreter’ doesn’t seem to support readline, yet ‘python-shell-completion-native-enable’ was t
;; For more info check this link https://emacs.stackexchange.com/questions/30082/your-python-shell-interpreter-doesn-t-seem-to-support-readline
;; Be aware that readline is deprecated, so one of the answers in the above blog doesn't count
(setq python-shell-completion-native-enable nil)

;; Bind dir-tree to F9
;; (global-set-key (kbd "<f9>") 'dir-treeview)
;; (load-theme 'dir-treeview-pleasant t)

;; paredit autoload
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'clojure-mode 'enable-paredit-mode)
(add-hook 'clojurescript-mode 'enable-paredit-mode)

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/RoamNotes")
  (org-roam-completion-everywhere t)
  (org-roam-dailies-capture-templates
   '(("d" "default" entry "* %<%I:%M %p>: %?" :target
  (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))
  (org-roam-capture-templates
   '(("d" "default" plain "%?" :target
      (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U\n")
      :unnarrowed t)
     ("b" "book notes" plain 
      "\n* Source\n\nAuthor: %^{Author}\nTitle: ${title}\nYear: %^{Year}\n\n* Summary\n\n%?"
      :target
      (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
     ))
  :bind (("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n i" . org-roam-node-insert)
	 :map org-mode-map
	 ("C-M-i" . completion-at-point)
	 :map org-roam-dailies-map
	 ("Y" . org-roam-dailies-capture-yesterday)
	 ("T" . org-roam-dailies-capture-today)
	 ("M" . org-roam-dailies-capture-tomorrow))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies)
  (org-roam-db-autosync-mode))

;; Solves the problem of not being able to write brackets or curly brackets
;; Watch out that paredit mode maps right-option + ] with something else
(setq mac-option-key-is-meta t)
(setq mac-right-option-modifier nil)

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/repos")
    (setq projectile-project-search-path '("~/repos")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package page-break-lines)
(use-package all-the-icons)

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  ;; Set the title
  (setq dashboard-banner-logo-title "Welcome back Andy :)")
  ;; Set the banner
  (setq dashboard-startup-banner 'logo)
  ;; Value can be
  ;; - nil to display no banner
  ;; - 'official which displays the official emacs logo
  ;; - 'logo which displays an alternative emacs logo
  ;; - 1, 2 or 3 which displays one of the text banners
  ;; - "path/to/your/image.gif", "path/to/your/image.png" or "path/to/your/text.txt" which displays whatever gif/image/text you would prefer
  ;; - a cons of '("path/to/your/image.png" . "path/to/your/text.txt")

  ;; Content is not centered by default. To center, set
  (setq dashboard-center-content t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-navigator t))

;; Set default csv-separators
(setq csv-separators '("," ";" "|" " " "	"))

(global-set-key (kbd "C-c t") 'treemacs)
(setq treemacs-projectile-follow-mode t)

(use-package grip-mode
  :ensure t 
  :hook ((markdown-mode org-mode) . grip-mode)
  :config (setq grip-preview-use-webkit t))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))
