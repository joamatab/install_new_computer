#!/usr/bin/env bash
# Install the basic software needed on a Debian desktop.

set -euo pipefail

if [[ ! -r /etc/os-release ]]; then
  echo "Unable to identify the operating system."
  exit 1
fi

. /etc/os-release
if [[ "${ID:-}" != "debian" && " ${ID_LIKE:-} " != *" debian "* ]]; then
  echo "This installer supports Debian-based systems only."
  exit 1
fi

sudo apt-get update
sudo apt-get install -y firefox-esr tmux
