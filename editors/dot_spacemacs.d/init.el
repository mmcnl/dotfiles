;; -*- mode: emacs-lisp -*-

;; (add-to-list 'load-path "/Users/matt/dev/benchmark-init-el/")
;; (require 'benchmark-init-loaddefs)
;; (benchmark-init/activate)

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation nil
   dotspacemacs-configuration-layers
   '(
     (auto-completion :variables
                      auto-completion-return-key-behavior nil
                      auto-completion-tab-key-behavior 'complete
                      auto-completion-enable-sort-by-usage t
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-private-snippets-directory nil)
     csv
     dap
     emacs-lisp
     fasd
     git
     github
     helm
     helpful
     html
     (dash :variables
           dash-autoload-common-docsets nil)
     (html :variables web-fmt-tool 'prettier)
     ibuffer
     ;; ipython-notebook
     (javascript :variables
                 js2-mode-show-strict-warnings nil
                 javascript-fmt-tool 'prettier
                 javascript-backend 'lsp
                 )
     (json :variables json-fmt-tool 'prettier)
     lsp
     ;; (rust :variables rust-backend 'lsp)
     ;; (lsp :variables lsp-rust-server 'rust-analyzer)
     (markdown :variables markdown-live-preview-engine 'vmd)
     neotree
     nginx
     matt
     org
     osx
     php
     prettier
     (python :variables
             python-formatter 'black
             python-sort-imports-on-save t
             python-format-on-save t
             python-backend 'lsp python-lsp-server 'pyright
             )
     ;; react
     ruby
     ;; (spell-checking :variables spell-checking-enable-by-default nil)
     ;; sql
     syntax-checking
     systemd
     (theming :variables theming-headings-inherit-from-default 'all theming-headings-same-size 'all theming-headings-bold 'all)
     (typescript :variables
                 typescript-linter 'eslint
                 typescript-fmt-tool 'typescript-formatter)
     version-control
     ;; (vue :variables vue-backend 'lsp)
     yaml
     )
   dotspacemacs-additional-packages '(
                                      ;; dockerfile-mode
                                      ;; flycheck-mypy
                                      ;; rjsx-mode
                                      ;; vimrc-mode
                                      ;; vlf
                                      ;; vue-mode
                                      ;; coffee-mode
                                      ;; flycheck-yamllint
                                      google-this
                                      ;; indium
                                      simpleclip
                                      undohist
                                      yafolding
                                      xterm-color
                                      )
   dotspacemacs-excluded-packages '(
                                    adaptive-wrap ;; https://github.com/syl20bnr/spacemacs/issues/1418#issuecomment-173703609
                                    inf-ruby
                                    magit-gitflow
                                    flyspell
                                    ;; syntax-checking
                                    ;; persp-mode
                                    perspective
                                    treemacs
                                    doom-modeline ;; avoid "apply: Args out of range:" error
                                    spray
                                    pbcopy ;; use simpleclip instead
                                    )
   ))
(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-active-transparency 100
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-check-for-update nil
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-command-key ""
   dotspacemacs-default-font '("Fira Code" :size 17)
   dotspacemacs-default-package-repository nil
   dotspacemacs-delete-orphan-packages nil
   dotspacemacs-editing-style 'vim
   dotspacemacs-elpa-https nil
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-enable-paste-transient-state t
   dotspacemacs-ex-substitute-global t
   ;; dotspacemacs-folding-method 'evil
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native t
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'top
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-use-fuzzy 'always
   dotspacemacs-highlight-delimiters 'current
   dotspacemacs-inactive-transparency 100
   dotspacemacs-leader-key "SPC"
   dotspacemacs-line-numbers nil
   dotspacemacs-loading-progress-bar t
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-mode-line-theme 'spacemacs
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-persistent-server nil ;; started by server-start below
   dotspacemacs-remap-Y-to-y$ t
   dotspacemacs-retain-visual-state-on-shift nil
   dotspacemacs-search-tools '("rg")
   dotspacemacs-show-transient-state-color-guide nil
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-smooth-scrolling t
   dotspacemacs-startup-banner nil
   dotspacemacs-startup-lists nil

   dotspacemacs-themes '(
                         atom-one-dark
                         solarized-light
                         )
   dotspacemacs-undecorated-at-startup nil
   dotspacemacs-use-ido nil
   dotspacemacs-verbose-loading nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-whitespace-cleanup 'changed
   )
  (add-to-list 'dotspacemacs-themes 'solarized-light t) ;; add to end of list
  )

(defun dotspacemacs/user-init ()
  "called immediately after `dotspacemacs/init'."

  ;; add custom config here that needs to precede spacemacs initialization

  ;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Saving-Customizations.html
  (setq custom-file "~/.emacs_customizations")

  (setq-default solarized-use-less-bold t)

  ;; stop useless warning about ENV vars being set in bashrc/zshrc
  (setq exec-path-from-shell-check-startup-files nil)

  ;; a recent change led to this dir not being picked up from shell PATH
  (add-to-list 'exec-path "/usr/local/bin")

  ;; this needs to be here to trigger spacemaces to add to ruby-mode-hook
  (setq ruby-version-manager 'chruby)
  )

(defun dotspacemacs/user-config ()
  "Called at end of Spacemacs initialization."

  (setq debug-on-error nil)
  ;; to disable custom config, comment out the line below
  (matt-load-deferred-config-files)
  ;; (benchmark-init/show-durations-tabulated)
  )
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
  )
