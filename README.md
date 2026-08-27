# Install new computer (inc) 0.1.16

Install basic software for different operating systems:

[See documentation](https://install-new-computer.readthedocs.io/en/latest/)

## Installation for users

First install [uv](https://docs.astral.sh/uv/):

```
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Then install `inc`:

```
uv tool install inc --python 3.12
```

## Usage

```
inc --help
```

### List available scripts

```
inc ls
```

Example output:
```
Available bash scripts:
  conda_python311
  conda_python312
  dotfiles
  gmsh
  new_mac
```

### Run a script

```
inc run <script_name>
```

For example, to install gmsh:
```
inc run gmsh
```

To see what a script would do without running it:
```
inc run gmsh --dry-run
```

### Install applications

Install an individual application with the native package manager:

```bash
inc apps install gh
```

For the same short workflow used by the script runner, catalog applications are
also available through `inc run` and appear in its completion list:

```bash
inc run gh
```

App and profile names support shell completion after running
`inc --install-completion`. For example, type `inc apps install g` and press Tab.

Preview the command without installing anything:

```bash
inc apps install gh --dry-run
```

Install a predefined group of applications without confirmation:

```bash
inc apps install --profile core --yes
inc apps install --profile dev --yes
```

Inspect the catalog and current installation state:

```bash
inc apps list
inc apps status
inc doctor
```

Applications and platform package mappings are declared in `inc/apps.toml`.
The supported package families are Arch/Manjaro, Debian/Ubuntu, Fedora/RHEL,
openSUSE, macOS/Homebrew, and Windows/WinGet.

### View script contents

```
inc cat <script_name>
```
## Installation for developers

```
git clone https://github.com/joamatab/install_new_computer.git ~/install_new_computer
cd ~/install_new_computer
uv sync
```

Install the local checkout as an editable command that works from any directory:

```bash
just tool-install
just tool-check
```

For MacOs type this into a terminal first:

```
xcode-select --install
```

## References

- [my dotfiles wiki](https://github.com/joamatab/dotfiles/wiki)
- [my dotfiles](https://github.com/joamatab/dotfiles)
- [mac CLI](https://github.com/guarinogabriel/mac-cli)
- https://github.com/jaywcjlove/awesome-mac.git
- https://www.stuartellis.name/articles/mac-setup/
- https://dotfiles.github.io/
- https://github.com/atomantic/dotfiles
- https://sourabhbajaj.com/mac-setup/
- https://github.com/gotbletu
- https://lukesmith.xyz/
- http://www.openvim.com/tutorial.html
