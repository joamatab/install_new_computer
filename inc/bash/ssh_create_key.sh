#!/bin/bash

########################################
# create SSH key and open gitlab / github
########################################

KEY_NAME="id_ed25519"
SSH_DIR="$HOME/.ssh"
KEY_PATH="$SSH_DIR/$KEY_NAME"

if [ -f "$KEY_PATH.pub" ]; then
  echo "SSH key already exists at $KEY_PATH.pub"
  echo "Copying public key to clipboard..."
else
  echo "==> Creating SSH key ($KEY_NAME)"
  echo "    This lets you connect to GitHub/GitLab without typing a password."
  echo ""
  echo "    Make sure you are logged in to GitHub and GitLab in your browser."
  echo "    Press Enter to open them now..."
  read

  if [ -d /Applications ]; then
    open 'https://github.com'
    open 'https://gitlab.com'
  elif [ ! -d /c ]; then
    xdg-open 'https://github.com' 2>/dev/null
    xdg-open 'https://gitlab.com' 2>/dev/null
  fi

  echo ""
  echo "==> Generating SSH key..."
  mkdir -p "$SSH_DIR"
  ssh-keygen -f "$KEY_PATH" -t ed25519 -N ''
  echo "    Key created at $KEY_PATH"

  echo ""
  echo "==> Starting ssh-agent and adding key..."
  eval "$(ssh-agent -s)"
  ssh-add "$KEY_PATH"
fi

# Copy public key to clipboard
if [ -d /Applications ]; then
  pbcopy < "$KEY_PATH.pub"
elif [ -d /c ]; then
  cat "$KEY_PATH.pub" | clip
else
  xclip -sel clip < "$KEY_PATH.pub"
fi

echo ""
echo "==> Public key copied to clipboard!"
echo ""
echo "    Paste it into your GitHub/GitLab SSH key settings:"
echo "    - https://github.com/settings/keys"
echo "    - https://gitlab.com/-/user_settings/ssh_keys"
echo ""
echo "    Press Enter to open these pages..."
read

if [ -d /Applications ]; then
  open 'https://github.com/settings/keys'
  open 'https://gitlab.com/-/user_settings/ssh_keys'
elif [ ! -d /c ]; then
  xdg-open 'https://github.com/settings/keys' 2>/dev/null
  xdg-open 'https://gitlab.com/-/user_settings/ssh_keys' 2>/dev/null
fi

echo "Done! Test with: ssh -T git@github.com"
