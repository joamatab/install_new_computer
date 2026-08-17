# Install uv (universal virtualenv)
uv:
	curl -LsSf https://astral.sh/uv/install.sh | sh

# Install dependencies
install:
    uv venv --python 3.11
    uv sync --extra docs --extra dev

dev:
    pip install -e .[dev,docs]

# Install the inc command globally while keeping this checkout editable
tool-install:
    uv tool install --editable . --python 3.12 --force

# Verify the globally installed command works outside this repository
tool-check:
    cd /tmp && inc --help && inc ls

# Add uv's executable directory to the shell PATH
tool-path:
    uv tool update-shell

# Remove the globally installed inc command
tool-uninstall:
    uv tool uninstall inc

test:
    pytest -s

cov:
    pytest --cov=inc

mypy:
    mypy . --ignore-missing-imports

# Remove merged branches
git-rm-merged:
    git branch -D `git branch --merged | grep -v \* | xargs`

# Update pre-commit hooks
update-pre:
    pre-commit autoupdate

# Build package
build:
    rm -rf dist
    pip install build
    python -m build

# Set up SSH for git
ssh:
    git remote remove origin
    git remote add origin git@github.com:joamatab/install_new_computer.git
    git push --set-upstream origin main

docs:
    uv run jb build docs

# Default target
default:
    install
