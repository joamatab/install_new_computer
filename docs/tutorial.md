
# Getting started

## Install `inc`

Install [uv](https://docs.astral.sh/uv/) and use it to install the released
command in an isolated environment:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
uv tool install inc --python 3.12
```

Confirm that the command is available:

```bash
inc --help
inc doctor
```

## Explore the available actions

`inc ls` shows both the original setup scripts and applications from the new
cross-platform catalog:

```bash
inc ls
```

Inspect a script before running it:

```bash
inc cat gmsh
inc run gmsh --dry-run
```

Inspect and preview catalog applications in the same way:

```bash
inc apps
inc run gh --dry-run
```

See {doc}`apps` for application profiles, supported package managers, shell
completion, and instructions for extending the catalog.

## Develop `inc`

Clone the repository and install the checkout as an editable global tool:

```bash
git clone https://github.com/joamatab/install_new_computer.git
cd install_new_computer
uv sync --extra dev --extra docs
uv tool install --editable . --python 3.12 --force
```

Changes under `inc/` are then visible immediately when running `inc` from a
different directory or terminal tab.

Run the checks and build the documentation with:

```bash
uv run pytest
uv run pre-commit run --all-files
uv run jupyter-book build docs
```
