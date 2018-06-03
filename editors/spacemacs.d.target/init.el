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
     ;; ipython-notebook
     ;; markdown
     ;; sql
     ;; (python :variables python-test-runner '(pytest nose))
     csv
     (auto-completion :variables auto-completion-return-key-behavior nil auto-completion-tab-key-behavior 'cycle auto-completion-enable-sort-by-usage t auto-completion-enable-snippets-in-popup t auto-completion-private-snippets-directory nil)
     helm
     html
     dash
     emacs-lisp
     git
     github
     html
     javascript
     matt
     org
     osx
     ruby
     (spell-checking :variables spell-checking-enable-by-default nil)
     syntax-checking
     (theming :variables theming-headings-inherit-from-default 'all theming-headings-same-size 'all theming-headings-bold 'all)
     version-control
     yaml
     )
   dotspacemacs-additional-packages '(
                                      ;; vimrc-mode
                                      ;; flycheck-mypy
                                      atom-one-dark-theme
                                      coffee-mode
                                      google-this
                                      rjsx-mode
                                      simpleclip
                                      undohist
                                      ;; vue-mode
                                      )
   dotspacemacs-excluded-packages '(
                                    ;; persp-mode ;; https://github.com/syl20bnr/spacemacs/issues/7409#issuecomment-254072953
                                    adaptive-wrap ;; https://github.com/syl20bnr/spacemacs/issues/1418#issuecomment-173703609
                                    inf-ruby
                                    magit-gitflow
                                    flyspell
                                    robe
                                    spacemacs-dark
                                    spray
                                    pbcopy
                                    )
   ))
(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-active-transparency 100
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-check-for-update nil
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-command-key ""
   dotspacemacs-default-font '("Source Code Pro" :size 15)
   dotspacemacs-default-package-repository nil
   dotspacemacs-delete-orphan-packages nil
   dotspacemacs-editing-style 'vim
   dotspacemacs-elpa-https nil
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-enable-paste-transient-state t
   dotspacemacs-ex-substitute-global t
   dotspacemacs-folding-method 'origami
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
   dotspacemacs-loading-progress-bar nil
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

   ;; dotspacemacs-themes '((atom-one-dark :location (recipe :fetcher github :repo "jonathanchu/atom-one-dark-theme"))
   ;;                       solarized-light)
   dotspacemacs-themes '(atom-one-dark
                         solarized-light)
   dotspacemacs-use-ido nil
   dotspacemacs-verbose-loading nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-whitespace-cleanup 'changed
   ))
;;
(defun dotspacemacs/user-init ()
  "called immediately after `dotspacemacs/init'."

  ;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Saving-Customizations.html
  (setq custom-file "~/.emacs_customizations")

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

  (spacemacs/toggle-maximize-frame-on)
  (my-org-setup)

  (server-start)

  ;; (benchmark-init/show-durations-tabulated)
  )
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
)
