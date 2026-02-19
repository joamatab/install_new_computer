#!/bin/sh

echo "==> Syncing wiki repositories to ~/wikis/..."

sync_wiki() {
  local name="$1"
  local repo="$2"
  local dest="$HOME/wikis/$name"

  if [ -d "$dest" ]; then
    echo "    Pulling latest $name..."
    cd "$dest"
    git pull
  else
    echo "    Cloning $name..."
    git clone "$repo" "$dest"
  fi
}

sync_wiki "joaquin"          "git@github.com:joamatab/joaquin.wiki.git"
sync_wiki "github"           "git@github.com:joamatab/dotfiles.wiki.git"
sync_wiki "gotbletu"         "https://github.com/gotbletu/shownotes.git"
sync_wiki "book-notes"       "git@github.com:joamatab/book-notes.git"
sync_wiki "awesome_photonics" "git@github.com:joamatab/awesome_photonics.git"
sync_wiki "dpd"              "git@github.com:doplaydo/wiki.wiki.git"

echo "==> Done! All wikis synced."
