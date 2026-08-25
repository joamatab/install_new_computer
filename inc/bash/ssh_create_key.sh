#!/bin/bash

########################################
# create SSH key
########################################

KEY_NAME="id_ed25519"
SSH_DIR="$HOME/.ssh"
KEY_PATH="$SSH_DIR/$KEY_NAME"

if [ -f "$KEY_PATH.pub" ]; then
  echo "SSH key already exists at $KEY_PATH.pub"
  echo "Copying public key to clipboard..."
else
  mkdir -p "$SSH_DIR"
  ssh-keygen -f "$KEY_PATH" -t ed25519 -N ''
  echo "    Key created at $KEY_PATH.pub"
  echo "==> Starting ssh-agent and adding key..."
  eval "$(ssh-agent -s)"
  ssh-add "$KEY_PATH"
fi
