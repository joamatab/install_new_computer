#!/bin/sh

[ ! -d ~/.rbenv ] && git clone https://github.com/rbenv/rbenv.git ~/.rbenv
[ ! -d ~/.rbenv/plugins/ruby-build ] && git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
