#!/bin/sh

echo "==> Installing md2gd (Markdown to Google Doc converter)..."
echo "    https://github.com/timwis/markdown-to-google-doc"

git clone https://github.com/timwis/markdown-to-google-doc.git
cp markdown-to-google-doc/md2gd ~/.local/bin/

echo "==> Done! md2gd installed to ~/.local/bin/"
