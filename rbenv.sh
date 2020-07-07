#!/bin/sh

[ ! -d ~/.rbenv ] && git clone https://github.com/rbenv/rbenv.git ~/.rbenv

# As an rbenv plugin
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

