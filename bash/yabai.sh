#!/bin/sh
# macOs tiling window manager

brew tap koekeishiya/formulae

brew install yabai
brew install skhd 
brew services start skhd
brew services start yabai
