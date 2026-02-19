#!/bin/bash

if [[ ! -f $HOME/Downloads/klayout.dmg ]]; then
  curl https://www.klayout.org/downloads/MacOS/klayout-0.25.9-macOS-Mojave-1-Qt5124mp.dmg > ~/Downloads/klayout.dmg
fi

open ~/Downloads/klayout.dmg
