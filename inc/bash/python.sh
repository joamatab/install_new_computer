#!/bin/sh

echo "==> Installing Python tools via uv..."

uv tool install ipython
uv tool install tbump
uv tool install towncrier
uv tool install pytest --with pytest-regressions

echo "==> Done! Python tools installed."
