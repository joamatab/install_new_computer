#!/bin/bash
# inspired in github.com/donnemartin/dev-setup

script_home="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $script_home/lib_sh/echos.sh
source $script_home/lib_sh/requirers.sh

running "Disable local Time Machine snapshots"
sudo tmutil disablelocal;ok

# running "Set standby delay to 24 hours (default is 10800 = 1 hour)"
# sudo pmset -a standbydelay 86400;ok

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# running "Disable the crash reporter"
# defaults write com.apple.CrashReporter DialogType -string "none";ok
# running "Avoid creating .DS_Store files on network volumes"
# defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true;ok

###############################################################################
# "Dock & Dashboard"
###############################################################################

running "Remove the auto-hiding Dock delay"
defaults write com.apple.dock autohide-delay -float 0;ok

running "Remove the animation when hiding/showing the Dock"
defaults write com.apple.dock autohide-time-modifier -float 0;ok

running "Set the icon size of Dock items to 36 pixels"
defaults write com.apple.dock tilesize -int 36;ok

running "Change minimize/maximize window effect to scale"
defaults write com.apple.dock mineffect -string "scale";ok

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.

defaults write com.apple.dock persistent-apps -array
killall Dock

defaults write com.apple.finder AppleShowAllFiles TRUE

###############################################################################
# Iterm2
###############################################################################
running "Don’t display the annoying prompt when quitting iTerm"
defaults write com.googlecode.iterm2 PromptOnQuit -bool false;ok
running "hide tab title bars"
defaults write com.googlecode.iterm2 HideTab -bool true;ok
running "hide pane titles in split panes"
defaults write com.googlecode.iterm2 ShowPaneTitles -bool false;ok

# running "set system-wide hotkey to show/hide iterm with ^\`"
# defaults write com.googlecode.iterm2 Hotkey -bool true;ok
