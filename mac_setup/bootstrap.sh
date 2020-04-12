# -*- mode: shell-script -*-

# iCloud preferences:
# Turn off: iCloud Drive, Mail

# Open activity monitor

# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

cd; git clone https://github.com/mmcnl/dotfiles

cd dotfiles && ./install

cd mac_setup
./brew_install.sh

# cp Backup/Users/matt/.private_dfiles ~

#############################
# misc apps to copy from:
#############################
# Backup/Users/matt/Applications/
# Backup/Users/matt/Library/Application Support/
# Backup/Users/matt/Library/Preferences/
# ---------------------------
# karabiner-elements
# better touch
# 1password
# dropbox


# -------------------- copy config files -------------------

# ~/.private_dfiles/
# ~/.dev_setup
# ~/.sh_setup_local
# /Users/matt/Library/QuickLook

gem install rcodetools

# npm
npm install -g vmd # github flavored markdown

 # show full path in finder title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true; killall Finder

# --------------- app store ----------------------
# growl

# install growlnotify from http://growl.info/downloads#generaldownloads

# after copying .rubies and installing chruby, set system ruby with:
echo "2.5.1" > ~/.ruby-version
