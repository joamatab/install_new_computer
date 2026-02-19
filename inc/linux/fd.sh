#!/bin/sh
# https://github.com/sharkdp/fd
# fd is a simple, fast and user-friendly alternative to find.

[ ! -f fd ] && git clone https://github.com/sharkdp/fd

# Build
# cd fd
# cargo build
# cargo test Run unit tests and integration tests

cargo install --path fd
