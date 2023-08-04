#!/bin/sh

python3 -m pip install --user pipx
python3 -m pipx ensurepath

pipx install black
pipx install bumpversion
pipx install gitcli
pipx install howdoi
pipx install ipython
pipx install jupyter
pipx install mypy
pipx install nbdime
pipx install notedown
pipx install pre-commit
pipx install pylint
pipx install ranger-fm
pipx install trash-cli
pipx install tox
pipx install virtualfish
pipx install cookiecutter
