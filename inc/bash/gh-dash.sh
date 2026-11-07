#!/bin/bash
set -euo pipefail

if ! command -v gh >/dev/null 2>&1; then
  echo "Install GitHub CLI (gh) and authenticate with 'gh auth login' first." >&2
  exit 1
fi

# A registered extension can still have a missing or broken executable.
if ! gh dash --version >/dev/null 2>&1; then
  if gh extension list | grep -qE '(^|[[:space:]])gh-dash([[:space:]]|$)'; then
    gh extension remove dash
  fi
  gh extension install dlvhdr/gh-dash
fi

gh dash --version
echo "Run 'gh dash' in an interactive terminal to open the dashboard."
