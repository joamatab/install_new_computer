#!/bin/bash
# brew cask installs GUI based applications

source ./lib_sh/echos.sh
source ./lib_sh/requirers.sh

running "checking brew-cask install"
output=$(brew tap | grep cask)
if [[ $output != 0 ]]; then
  action "installing brew-cask"
  require_brew caskroom/cask/brew-cask
fi

for i in \
  visual-studio-code \
  openemu \
  ultrastardeluxe \
  caffeine \
  obs \
  macvim \
  firefox \
  ghostty
  # bitwarden \
  # dupeguru \
  # github \
  # iterm2 \
  # karabiner-elements \
  # keepassx \
  # kitty \
  # klayout \
  # nextcloud \
  # osxfuse \
  # oni \
  # pdftotext \
  # sublime-text \
do
  require_cask $i
done
