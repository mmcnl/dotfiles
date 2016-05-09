;; -*- mode: emacs-lisp -*-

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   dotspacemacs-elpa-https nil
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-configuration-layers
   '(
     (auto-completion :variables
                      auto-completion-return-key-behavior nil
                      auto-completion-tab-key-behavior 'cycle
                      auto-completion-enable-sort-by-usage t
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-private-snippets-directory nil)
     spacemacs-helm
     csv
     dash
     emacs-lisp
     fasd
     (git :variables git-magit-status-fullscreen t)
     github
     html
     ipython-notebook
     javascript
     markdown
     matt
     org
     osx
     pdf-tools
     (python :variables python-test-runner 'pytest)
     ruby
     (spell-checking :variables spell-checking-enable-by-default nil)
     sql
     syntax-checking
     terraform
     (theming :variables
              theming-headings-inherit-from-default 'all
              theming-headings-same-size 'all
              theming-headings-bold 'all)
     version-control
     yaml
     )
   dotspacemacs-additional-packages '(
                                      atom-one-dark-theme
                                      company-jedi
                                      dired-single
                                      google-this
                                      flycheck-mypy
                                      undohist
                                      vimrc-mode
                                      powerline
                                      )
   dotspacemacs-excluded-packages '(
                                    evil-search-highlight-persist
                                    robe
                                    spray
                                    adaptive-wrap ;; https://github.com/syl20bnr/spacemacs/issues/1418#issuecomment-173703609
                                    inf-ruby
                                    spaceline
                                    )
   dotspacemacs-delete-orphan-packages nil
   ))
(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-elpa-https nil
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner nil
   dotspacemacs-startup-lists nil
   dotspacemacs-startup-recent-list-size 0
   dotspacemacs-themes '(atom-one-dark solarized-light)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("Source Code Pro" :size 15)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-command-key ""
   dotspacemacs-remap-Y-to-y$ t
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-max-rollback-slots 3
   dotspacemacs-use-ido nil
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-enable-paste-transient-state t
   dotspacemacs-show-transient-state-color-guide nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar nil
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native t
   dotspacemacs-maximized-at-startup t
   dotspacemacs-active-transparency 100
   dotspacemacs-inactive-transparency 100
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling nil
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-highlight-delimiters 'current
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("ag")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup 'changed
   dotspacemacs-check-for-update nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   dotspacemacs-ex-substitute-global t
   dotspacemacs-retain-visual-state-on-shift nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init'.  You are free to put any
user code."
  ;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Saving-Customizations.html
  (setq custom-file "/tmp/emacs_customizations")

  (setq-default solarized-use-less-bold t)

  ;; stop useless warning about ENV vars being set in bashrc/zshrc
  (setq exec-path-from-shell-check-startup-files nil)

  ;; this needs to be here to trigger spacemaces to add to ruby-mode-hook
  (setq ruby-version-manager 'chruby)
  )

(defun dotspacemacs/user-config ()
  "Called at end of Spacemacs initialization."
  (matt-load-deferred-config-files)
  )
