#!/bin/bash

if [[ ! -f $HOME/Downloads/klayout.dmg ]]; then
  curl https://www.klayout.org/downloads/MacOS/ARM64/arm64ST-klayout-0.30.6-macOS-Tahoe-1-qt5MP-RsysPsys.dmg > ~/Downloads/klayout.dmg
fi
open ~/Downloads/klayout.dmg
