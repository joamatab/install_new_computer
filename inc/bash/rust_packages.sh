#!/bin/sh

echo "==> Installing Rust and cargo packages..."

if ! command -v cargo &> /dev/null; then
  echo "    Installing Rust via rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  . "$HOME/.cargo/env"
else
  echo "    Rust already installed: $(rustc --version)"
fi

echo "    Installing cargo packages: starship, ripgrep, tokei, sd, hyperfine, du-dust, dutree, mcfly, skim, fastmod, bat, fd"

cargo install ripgrep tokei sd hyperfine du-dust dutree mcfly skim fastmod bat fd

echo "    Installing zoxide..."
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/ajeetdsouza/zoxide/master/install.sh | sh

echo "==> Done! Rust packages installed."
