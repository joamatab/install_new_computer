#!/bin/bash

# Define the URL and the destination directory
URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/RobotoMono.tar.xz"
DEST_DIR="$HOME/.local/share/fonts"

# Create the destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Download and extract the font package
if command -v curl >/dev/null 2>&1; then
    curl -L "$URL" | tar xJ -C "$DEST_DIR"
elif command -v wget >/dev/null 2>&1; then
    wget -O - "$URL" | tar xJ -C "$DEST_DIR"
else
    echo "Error: Neither curl nor wget found. Please install one of them." >&2
    exit 1
fi

# Check if the extraction was successful
if [ $? -eq 0 ]; then
    echo "Font installed successfully in $DEST_DIR"
else
    echo "Error: Font installation failed." >&2
    exit 1
fi
