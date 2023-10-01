#!/usr/bin/env python3
"""
adapted from https://github.com/hauntsaninja/personal_setup/blob/master/run.py

"""

import argparse
import functools
import subprocess
import textwrap
from pathlib import Path


def blue_print(arg):
    print(f"\033[1;34m{arg}\033[0m")


def pretty_name(fn):
    return " ".join(fn.__name__.split("_")).title()


def run(cmd, verbose=True):
    if verbose:
        blue_print(cmd)
    proc = subprocess.Popen(
        ["/bin/bash", "-c", cmd],
        bufsize=1,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        cwd=Path(__file__).parent,
        universal_newlines=True,
    )
    while True:
        if verbose:
            out = proc.stdout.readline()
            print(textwrap.indent(out, "\t"), end="")
            if out:
                continue
        if proc.poll() is not None:
            break
    return proc.poll()


fns = []  # functions


def collect(fn):
    global fns
    fns.append(fn)
    return fn


def skip_if(cmd, should_fail=False, should_raise=False):
    def decorator(fn):
        @functools.wraps(fn)
        def inner(*args, **kwargs):
            returncode = run(cmd, verbose=False)
            command_failed = bool(returncode)
            if should_fail:
                command_failed = not command_failed
            if command_failed:
                fn(*args, **kwargs)
            elif should_raise:
                raise subprocess.CalledProcessError(returncode, cmd)
            else:
                blue_print("=" * 25)
                blue_print(f"Skipping installing {pretty_name(fn)}...")
                blue_print("=" * 25)
                print()

        return inner

    return decorator


skip_if_fail = functools.partial(skip_if, should_fail=True)
raise_if_fail = functools.partial(skip_if, should_fail=True, should_raise=True)


def sh(check=True):
    def decorator(fn):
        @functools.wraps(fn)
        def inner(*args, **kwargs):
            blue_print("=" * 25)
            blue_print(f"Installing {pretty_name(fn)}...")
            blue_print("=" * 25)
            print()
            if not ARGS.yes:
                print("Enter to continue (or type something to skip)... ", end="")
                if input():
                    print()
                    return
            lines = fn(*args, **kwargs).splitlines()
            for line in lines:
                cmd = line.strip()
                if not cmd:
                    continue
                returncode = run(cmd)
                if check and returncode:
                    print("\n")
                    raise subprocess.CalledProcessError(returncode, cmd)
            print()

        return inner

    return decorator


# ==========================
# The actual setup begins...
# ==========================


@sh()
def zsh():
    return """
    [[ ! -f ~/.zshrc ]] || diff zshrc ~/.zshrc
    cp zshrc ~/.zshrc
    # zsh -c 'compaudit | xargs chmod g-w'
    rm -rf ~/.zgen
    git clone https://github.com/tarjoilija/zgen.git ~/.zgen
    zsh -i -c ''
    [[ $SHELL = "$(which zsh)" ]] || chsh -s $(which zsh)
    touch ~/.z
    """


@sh()
def vim():
    return """
    [[ ! -f ~/.vimrc ]] || diff vimrc ~/.vimrc
    cp vimrc ~/.vimrc
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    rm -rf ~/.vim/.swp
    mkdir ~/.vim/.swp
    """


@collect
@skip_if_fail("lsb_release")
@sh()
def ubuntu_stuff():
    return """
    mkdir -p ${HOME}/.local/bin
    git clone --depth 1 https://github.com/junegunn/fzf.git /tmp/fzf
    /tmp/fzf/install --bin
    mv /tmp/fzf/bin/fzf ${HOME}/.local/bin
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
    sudo dpkg -i ripgrep_12.1.1_amd64.deb
    python3 -m pip install pypyp virtualenv
    """


@collect
@skip_if("which brew")
@sh()
def brew():
    return '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"'


@collect
@skip_if_fail("which brew")
@sh()
def main_brew_stuff():
    return """
    brew reinstall python3
    brew reinstall node
    brew reinstall ripgrep  # code search
    brew reinstall fzf      # fuzzy finder
    brew reinstall pipx     # manage python apps in their own venvs
    brew reinstall pyenv    # manage python versions
    brew reinstall htop     # view processes
    brew reinstall tree     # show a directory tree
    """


@collect
@skip_if_fail("which brew")
@sh()
def provisional_brew_stuff():
    return """
    brew reinstall fd         # like find but sometimes more convenient
    brew reinstall bat        # like cat with syntax highlighting
    brew reinstall tokei      # count lines in code
    brew reinstall hyperfine  # benchmarking
    brew reinstall dust       # like du + tree
    brew reinstall gh         # github cli
    brew reinstall fastmod    # fast codemod (i hate sed)
    brew reinstall watch      # repeatedly run a command
    brew reinstall prettier   # code formatter
    brew reinstall jq         # parse json
    brew reinstall pwgen      # password generator, used by zsh-autoswitch-virtualenv
    """


@collect
@skip_if_fail("which brew")
@sh()
def brew_casks():
    return """
    brew install --cask hammerspoon  # automate your mac
    brew install --cask basictex
    brew install --cask firefox
    brew install --cask google-chrome
    brew install --cask spotify
    brew install --cask atom
    brew install --cask visual-studio-code
    """


@collect
@skip_if_fail("brew list --cask | grep hammerspoon")
@sh()
def hammerspoon_config():
    return """
    [[ ! -f ~/.hammerspoon/init.lua ]] || diff hammerspoon.lua ~/.hammerspoon/init.lua
    rm -rf ~/.hammerspoon
    mkdir ~/.hammerspoon
    cp hammerspoon.lua ~/.hammerspoon/init.lua
    """


@collect
@skip_if_fail("which apm")
@sh()
def apm():
    return "apm install sync-settings"


@collect
@raise_if_fail("which python3")
@sh()
def python_libraries():
    return """
    python3 -m pip install aiohttp
    python3 -m pip install beautifulsoup4
    python3 -m pip install pandas
    python3 -m pip install python-dateutil
    python3 -m pip install ipdb
    python3 -m pip install ipython
    """


@collect
@raise_if_fail("which pipx")
@sh()
def python_tools():
    return """
    # use python on the command line easily
    pipx install pypyp
    # some extra git commands
    pipx install git-revise
    pipx install git-delete-merged-branches
    # python formatting
    pipx install black
    pipx install darker
    pipx install isort
    # python linting
    pipx install flake8
    pipx inject flake8 flake8-pyi flake8-bugbear
    pipx install pylint
    pipx install mypy
    # python packaging, testing, profiling
    pipx install poetry
    pipx install pyinstrument
    pipx install pytest
    pipx inject pytest pytest-cov pytest-xdist
    pipx install tox
    pipx install virtualenv
    """


def main():
    global ARGS
    global fns

    parser = argparse.ArgumentParser()
    parser.add_argument("--yes", action="store_true", help="Don't ask, just do!")
    parser.add_argument("sections", nargs="*", help="Things to run")
    ARGS = parser.parse_args()

    for fn in fns:
        if not ARGS.sections or any(x == fn.__name__.lower() for x in ARGS.sections):
            fn()


if __name__ == "__main__":
    main()
