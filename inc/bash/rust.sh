#!/bin/sh

echo "==> Installing Rust via rustup..."

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "==> Done! Restart your shell to use cargo and rustc."
