#!/bin/sh

brew update
# brew tap burntsushi/ripgrep https://github.com/BurntSushi/ripgrep.git

formulas=(
    ansible
    ansible-lint
    bandwhich
    bash
    bash-completion
    bat
    chruby
    coreutils
    ctags
    diff-so-fancy
    direnv
    fasd
    fd
    findutils
    fzf
    git
    htop
    iftop
    lf
    memcached
    ncdu
    nmap
    postgresql
    prettyping
    pv
    python
    redis
    ripgrep
    rsync
    ruby-install
    scantailor-osx
    speedtest-cli
    tldr
    trash
    tree
    watch
    yapf
    youtube-dl
    zsh-completions
)
brew install ${formulas[@]}

brew install emacs-plus --without-spacemacs-icon

# cask
brew tap homebrew/cask

# https://github.com/sindresorhus/quick-look-plugins
xattr -d -r com.apple.quarantine ~/Library/QuickLook
brew cask install qlstephen qlmarkdown quicklook-json qlimagesize suspicious-package qlvideo
