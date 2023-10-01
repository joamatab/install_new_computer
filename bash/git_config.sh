#!/bin/bash

# Store where the script was called from so we can reference it later
source lib_sh/echos.sh
source lib_sh/requirers.sh


################################
# passwordless sudo for MacOs
################################

# Ask for the administrator password upfront
if [ -d /Applications ]; then
  if ! sudo grep -q "%wheel		ALL=(ALL) NOPASSWD: ALL #atomantic/dotfiles" "/etc/sudoers"; then
    bot "I need you to enter your sudo password so I can install some things:"
    sudo -v

    # Keep-alive: update existing sudo time stamp until the script has finished
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

    # run sudo without a password
    # http://wiki.summercode.com/sudo_without_a_password_in_mac_os_x

    sudo cp /etc/sudoers /etc/sudoers.bak
    echo '%wheel		ALL=(ALL) NOPASSWD: ALL #atomantic/dotfiles' | sudo tee -a /etc/sudoers > /dev/null
    sudo dscl . append /Groups/wheel GroupMembership $(whoami)
  fi
fi

################################
# git config
# exit(0) indicates successful program termination 
# exit(1) (usually) indicates unsucessful termination
################################

grep -q 'email' ~/.gitconfig > /dev/null 2>&1

if [ $? != 0 ]; then
    read -r -p "What is your git username? " gituser
    read -r -p "What is your git email? " gitemail

  git config --global user.name $gituser
  git config --global user.email $gitemail
  git config --global core.editor /usr/bin/vim
  git config --global core.excludesfile $HOME/.gitignore
  echo "updated .gitconfig with your info ($gituser, $gitemail)"
fi

