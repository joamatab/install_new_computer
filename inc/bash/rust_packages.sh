#!/bin/sh

echo "==> Installing Rust packages via cargo..."
echo "    starship, ripgrep, tokei, sd, hyperfine, du-dust, dutree, mcfly, skim, alacritty, fastmod, bat"

cargo install starship ripgrep tokei sd hyperfine du-dust dutree mcfly skim alacritty fastmod bat

echo "    Installing zoxide..."
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/ajeetdsouza/zoxide/master/install.sh | sh

echo "    Installing fd..."
bash fd.sh

echo "==> Done! Rust packages installed."
