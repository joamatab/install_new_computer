#!/bin/bash

python3 -m pip install --user pipx
python3 -m pipx ensurepath


packages=(
    black
    bumpversion
    cookiecutter
    howdoi
    ipython
    jupyter
    mypy
    nbdime
    neovim
    notedown
    pre-commit
    pylint
    ranger-fm
    sourcery
    tox
    trash-cli
    # gitcli
    # virtualfish
)

for package in "${packages[@]}"; do
    pipx install "$package"
done
