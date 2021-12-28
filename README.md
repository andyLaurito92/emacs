Personal emacs config

1. Before you can use the .emacs, you need to install SBCL and quicklisp. In order to do so, run:
1.1. brew install sbcl
1.2. Tutorial https://www.quicklisp.org/beta/
1.3. After running the basic installation, run:
1.3.1.	   (ql:add-to-init-file)
1.3.2	   (ql:quickload "quicklisp-slime-helper")
2. Open Emacs and run: M-x package-refresh-contents
3. M-x package-install RET dracula-theme
4. M-x package-install RET powerline
5. Take a look at https://github.com/emacs-eaf/emacs-application-framework
