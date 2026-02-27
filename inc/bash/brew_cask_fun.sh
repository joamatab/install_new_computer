#!/bin/bash
# brew cask installs GUI based applications

source ./lib_sh/echos.sh
source ./lib_sh/requirers.sh

echo "==> Installing desktop apps via Homebrew Cask..."

running "checking brew-cask install"
output=$(brew tap | grep cask)
if [[ $output != 0 ]]; then
  action "installing brew-cask"
  require_brew caskroom/cask/brew-cask
fi

for i in \
  openemu \
  ultrastardeluxe
do
  require_cask $i
done

echo "==> Done! Desktop apps installed."
