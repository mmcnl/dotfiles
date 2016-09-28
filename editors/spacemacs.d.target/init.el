;; -*- mode: emacs-lisp -*-

;; (add-to-list 'load-path "/Users/matt/dev/benchmark-init-el/")
;; (require 'benchmark-init-loaddefs)
;; (benchmark-init/activate)

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-configuration-layers
   '(
     (auto-completion :variables
                      auto-completion-return-key-behavior nil
                      auto-completion-tab-key-behavior 'cycle
                      auto-completion-enable-sort-by-usage t
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-private-snippets-directory nil)
     helm
     html
     csv
     dash
     emacs-lisp
     (git :variables git-magit-status-fullscreen t)
     github
     html
     ;; ipython-notebook
     javascript
     ;; markdown
     matt
     org
     osx
     ;; (python :variables python-test-runner '(pytest nose))
     ruby
     (spell-checking :variables spell-checking-enable-by-default nil)
     ;; sql
     syntax-checking
     (theming :variables
              theming-headings-inherit-from-default 'all
              theming-headings-same-size 'all
              theming-headings-bold 'all)
     version-control
     yaml
     )
   dotspacemacs-additional-packages '(
                                      atom-one-dark-theme
                                      dired-single
                                      google-this
                                      simpleclip
                                      undohist
                                      ;; vimrc-mode
                                      ;; flycheck-mypy
                                      )
   dotspacemacs-excluded-packages '(
                                    adaptive-wrap ;; https://github.com/syl20bnr/spacemacs/issues/1418#issuecomment-173703609
                                    inf-ruby
                                    magit-gitflow
                                    robe
                                    spray
                                    )
   dotspacemacs-download-packages 'used-but-keep-unused
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
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-use-ido nil
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-enable-paste-transient-state t
   dotspacemacs-show-transient-state-color-guide nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-loading-progress-bar nil
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native t
   dotspacemacs-maximized-at-startup t
   dotspacemacs-active-transparency 100
   dotspacemacs-inactive-transparency 100
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-highlight-delimiters 'current
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("ag")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup 'changed
   dotspacemacs-check-for-update nil
   dotspacemacs-ex-substitute-global t
   dotspacemacs-retain-visual-state-on-shift nil
   dotspacemacs-folding-method 'origami
   ))

(defun dotspacemacs/user-init ()
  "called immediately after `dotspacemacs/init'."

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

  ;; to disable custom config, comment out the line below
  (matt-load-deferred-config-files)

  ;; hide compilation buffer
  (delete-other-windows)

  ;; (benchmark-init/show-durations-tabulated)
  )
