#!/bin/sh

cargo install starship ripgrep tokei sd hyperfine du-dust dutree mcfly skim alacritty fastmod
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/ajeetdsouza/zoxide/master/install.sh | sh
bash fd.sh
