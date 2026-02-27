# Install new computer (inc) 0.1.13

Install basic software for different operating systems:

[See documentation](https://install-new-computer.readthedocs.io/en/latest/)

## Installation for users

First install [uv](https://docs.astral.sh/uv/):

```
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Then install `inc`:

```
uv tool install inc
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
  install_new_mac
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
