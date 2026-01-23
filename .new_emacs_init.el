;; init.el --- Robust Python & Evil Configuration -*- lexical-binding: t; -*-

;; Disable package.el completely
(setq package-enable-at-startup nil)

;; ----------------------------------------
;; Early Key-Map Definitions (Prevents Prefix Errors)
;; ----------------------------------------
(global-unset-key (kbd "C-c r"))
(define-prefix-command 'andy-org-roam-map)
(global-set-key (kbd "C-c r") 'andy-org-roam-map)

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

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)   ;; Sets Command to Meta (M-)
  (setq mac-option-modifier 'none)    ;; Leaves Option for special characters (like symbols)
  ;; (setq mac-option-modifier 'alt)  ;; Alternative: set Option to Alt if you prefer
  
  ;; Make sure Emacs recognizes the right Command key on modern keyboards
  (setq ns-function-modifier 'control))

;; Set default frame size (Height x Width)
(add-to-list 'default-frame-alist '(height . 60))
(add-to-list 'default-frame-alist '(width . 170))

;; Optional: If you want the current frame to resize immediately on load
(set-frame-size (selected-frame) 170 50)


;; ----------------------------------------
;; 5. Theme & Modeline
;; ----------------------------------------
(use-package doom-themes
  :demand t
  :init
  (load-theme 'doom-dracula t)
  :config
  (setq doom-themes-enable-bold t 
        doom-themes-enable-italic t)
  (doom-themes-org-config))

(use-package doom-modeline
  :demand t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-height 15)
  )
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


;; ----------------------------------------
;; 13. Lisp Development & Structural Editing
;; ----------------------------------------

;; Set standard Lisp indentation (2 spaces)
(setq lisp-indent-offset 2)
(setq emacs-lisp-mode-hook '((lambda () (setq lisp-indent-offset 2))))


;; Paredit: Provides structural editing (keeps parentheses balanced)
(use-package paredit
  :hook ((emacs-lisp-mode 
          lisp-mode 
          clojure-mode 
          scheme-mode 
          lisp-interaction-mode) . enable-paredit-mode)
  :config
  ;; Enable paredit in the minibuffer for eval-expression
  (add-hook 'minibuffer-setup-hook 
            (lambda ()
              (when (memq this-command '(eval-expression pp-eval-expression))
                (enable-paredit-mode)))))

;; Paredit Everywhere: Enables paredit features in non-lisp modes (strings, etc.)
(use-package paredit-everywhere
  :hook (prog-mode . paredit-everywhere-mode))

;; SLIME: The Superior Lisp Interaction Mode for Common Lisp
(use-package slime
  :init
  (setq inferior-lisp-program "sbcl") ; Matches your old config
  :config
  ;; Load the quicklisp helper if it exists
  (let ((slime-helper "~/quicklisp/slime-helper.el"))
    (when (file-exists-p (expand-file-name slime-helper))
      (load (expand-file-name slime-helper))))
  
  ;; Ensure paredit works inside the SLIME REPL
  (add-hook 'slime-repl-mode-hook #'enable-paredit-mode))

;; ----------------------------------------
;; 14. Org Mode & Roam (Writing & Notes)
;; ----------------------------------------

(use-package org
  :straight t 
  :hook (org-mode . (lambda ()
                      (org-indent-mode)
                      (variable-pitch-mode 1)
                      (visual-line-mode 1)))
  :config
  (setq org-ellipsis " ⤵"
        org-hide-mphasis-markers t
        org-startup-indented t
        org-hide-leading-stars t
        org-agenda-files '("~/org")))

;; Force Org to load completely BEFORE Org-Roam starts
(with-eval-after-load 'org
  (require 'org-element))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("•" "◦" "▸" "▹")))

(use-package org-roam
  :after org
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory (file-truename "~/RoamNotes"))
  (org-roam-completion-everywhere t)
  :bind (:map andy-org-roam-map
         ("l" . org-roam-buffer-toggle)
         ("f" . org-roam-node-find)
         ("i" . org-roam-node-insert)
         ("g" . org-roam-graph)
         ("c" . org-roam-capture)
         ("j" . org-roam-dailies-capture-today)
         :map org-mode-map
         ("C-M-i" . completion-at-point))
  :config
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?" 
           :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U\n")
           :unnarrowed t)
          ("b" "book notes" plain 
           "\n* Source\n\nAuthor: %^{Author}\nTitle: ${title}\nYear: %^{Year}\n\n* Summary\n\n%?"
           :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
           :unnarrowed t)))
  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry "* %<%I:%M %p>: %?" 
           :target (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))

  (org-roam-db-autosync-mode)
  (require 'org-roam-dailies))


;; ----------------------------------------
;; 15. AI Assistance (Copilot & Ollama)
;; ----------------------------------------

;; GPTel: Interface for Ollama/Local LLMs
(use-package gptel
  :config
  (setq gptel-model 'llama3.2:latest
        gptel-backend (gptel-make-ollama "Ollama" 
                                         :host "localhost:11434" 
                                         :stream t 
                                         :models '(llama3.2:latest))))

;; Github Copilot
(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . copilot-accept-completion)
              ("TAB" . copilot-accept-completion)
              ("C-f" . copilot-accept-completion-by-word)
              ("M-n" . copilot-next-completion)
              ("M-p" . copilot-previous-completion))
  :config
  ; Fix the "no mode-specific indentation offset" warning
  (setq copilot-indent-offset-alist
        '((python-mode . python-indent-offset)
          (emacs-lisp-mode . lisp-indent-offset)
          (lisp-mode . lisp-indent-offset)
	  (common-lisp-mode . lisp-indent-offset)
          (yaml-mode . yaml-indent-offset)
          (csv-mode . 0))) ; CSVs don't really indent
  ;; Ensure dependencies are available
  (require 'editorconfig)
  (require 'dash)
  (require 's)
  (require 'f))

;; ----------------------------------------
;; 16. UI Polish & Quality of Life
;; ----------------------------------------

;; Use y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; 1. Setup Initial Transparency
(defvar andy/opacity-level 85)
(set-frame-parameter (selected-frame) 'alpha `(,andy/opacity-level . 85))
(add-to-list 'default-frame-alist `(alpha . (,andy/opacity-level . 50)))

;; 2. The Toggle Function
(defun andy/toggle-transparency ()
  "Toggle between transparent and opaque frames."
  (interactive)
  (let ((current-alpha (car (frame-parameter nil 'alpha))))
    (if (and current-alpha (< current-alpha 100))
        (set-frame-parameter nil 'alpha '(100 . 100))
      (set-frame-parameter nil 'alpha `(,andy/opacity-level . 50)))))

;; 3. Keybinding for Transparency
(global-set-key (kbd "C-c T") #'andy/toggle-transparency)

;; Window Switching (Easier than C-x o)
(use-package switch-window
  :bind ("C-x o" . switch-window))

;; macOS Specific Browse
(use-package osx-browse
  :if (eq system-type 'darwin)
  :config (osx-browse-mode 1))

;; Dashboard (The startup screen)
(use-package dashboard
  :demand t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "Welcome back Andy :)"
        dashboard-startup-banner 'logo
        dashboard-center-content t
        dashboard-set-heading-icons t
        dashboard-set-file-icons t))

;; Clean up the title bar to show file path
(setq-default frame-title-format "%b (%f)")

;; ----------------------------------------
;; 17. Languages & File Management
;; ----------------------------------------

;; CSV Files
(use-package csv-mode
  :mode ("\\.csv\\'" . csv-mode)
  :config
  (setq csv-separators '("," ";" "|" " " "    ")))

;; YAML Files
(use-package yaml-mode
  :mode ("\\.yml\\'" . yaml-mode))

;; Rainbow Identifiers (Colorizes variables uniquely)
(use-package rainbow-identifiers
  :hook (prog-mode . rainbow-identifiers-mode))

;; Ported Backup/Auto-save Logic
(setq backup-directory-alist `(("." . ,(expand-file-name "saves" user-emacs-directory)))
      auto-save-file-name-transforms `((".*" ,(expand-file-name "auto-save/" user-emacs-directory) t))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Ensure directories exist
(make-directory (expand-file-name "saves" user-emacs-directory) t)
(make-directory (expand-file-name "auto-save" user-emacs-directory) t)

;; ----------------------------------------
;; 18. Personal Utilities & Scratch Files
;; ----------------------------------------

(defun andy/create-scratch-file (file-extension)
  "Creates a temporary file with the FILE-EXTENSION provided.
Ported from old config."
  (interactive "sEnter file extension (e.g., py, el, md): ")
  (let ((temp-file (make-temp-file "andy-scratch-" nil (concat "." file-extension))))
    (find-file-other-window temp-file)))

;; Optional: Bind it to a key
(global-set-key (kbd "C-c c s") #'andy/create-scratch-file)

;; Allow erasing buffers without confirmation (from old config)
(put 'erase-buffer 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; Provide a feature name for the whole file
(provide 'init)

;;; init.el ends here
