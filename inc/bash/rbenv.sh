#!/bin/sh

echo "==> Installing rbenv (Ruby version manager)..."

if [ -d ~/.rbenv ]; then
  echo "    rbenv already installed."
else
  echo "    Cloning rbenv..."
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
fi

if [ -d ~/.rbenv/plugins/ruby-build ]; then
  echo "    ruby-build plugin already installed."
else
  echo "    Cloning ruby-build plugin..."
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

echo "==> Done! Add '~/.rbenv/bin' to your PATH, then run 'rbenv install <version>'."
