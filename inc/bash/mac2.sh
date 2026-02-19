#!/bin/bash

echo "==> Configuring macOS screenshot behavior..."
echo "    Setting screenshots to copy to clipboard instead of saving to file..."

defaults write com.apple.screencapture target clipboard
killall SystemUIServer

echo "==> Done! Screenshots will now copy to clipboard."
