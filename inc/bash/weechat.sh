#!/bin/bash
# Install wee-slack for Slack in the terminal
# https://github.com/wee-slack/wee-slack

set -euo pipefail

echo "==> Setting up wee-slack..."

if ! command -v weechat &>/dev/null; then
  echo "weechat not found. Install it first (brew install weechat)."
  exit 1
fi

# Install Python dependency
brew install python-websocket-client 2>/dev/null || python3 -m pip install --break-system-packages websocket-client

echo "==> wee-slack dependencies installed!"
echo ""
echo "Next steps:"
echo "  1. Run: weechat"
echo "  2. Install the plugin:  /script install slack.py"
echo "  3. Install notifications: /script install notification_center.py"
echo "  4. Register workspace: /slack register"
echo "  5. Follow the link to authorize, then paste the code back"
echo "  6. Reload: /python reload slack"
