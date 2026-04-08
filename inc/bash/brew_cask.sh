#!/bin/bash
# brew cask installs GUI based applications

script_home="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$script_home/lib_sh/echos.sh"
source "$script_home/lib_sh/requirers.sh"

echo "==> Installing desktop apps via Homebrew Cask..."

for i in \
  antigravity \
  caffeine \
  firefox \
  flameshot \
  ghostty \
  google-chrome \
  neovide \
  obs \
  visual-studio-code \
  zed
  # cursor \
  # bitwarden \
  # macvim \
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

echo "==> Done! Desktop apps installed."
