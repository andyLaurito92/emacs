Personal emacs config

Switching in OSX to use doom-emacs. I followed this installation steps: https://github.com/doomemacs/doomemacs/blob/develop/docs/getting_started.org#with-homebrew (installed emacs-mac)

If having issues with fonts, just run `M-x all-the-icons-install-fonts`
1. Before you can use the .emacs, you need to install SBCL and quicklisp. In order to do so, run:
1.1. brew install sbcl
1.2. Tutorial https://www.quicklisp.org/beta/
1.3. After running the basic installation, run:
1.3.1.	   (ql:add-to-init-file)
1.3.2	   (ql:quickload "quicklisp-slime-helper")
2. Open Emacs and run: M-x package-refresh-contents
3. M-x package-install RET dracula-theme
4. M-x package-install RET powerline
5. Remember to install elpy python libraries as explained [here](https://elpy.readthedocs.io/en/latest/introduction.html#installation)
6. Take a look at https://github.com/emacs-eaf/emacs-application-framework
