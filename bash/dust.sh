#!/bin/sh

[ ! -d dust ] && git clone git@github.com:bootandy/dust.git
cd dust
cargo install --path .
