#!/bin/bash

set -euo pipefail

if ! command -v pacman >/dev/null 2>&1; then
    echo "This script configures an SSH server on Arch Linux."
    exit 1
fi

echo "==> Installing OpenSSH..."
sudo pacman -S --needed openssh

echo "==> Enabling and starting the SSH server..."
sudo systemctl enable --now sshd.service

echo "==> Done. Connect from your Mac with: ssh <user>@<arch-ip-or-hostname>"
