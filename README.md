# Install new computer (inc) 0.1.7

Install basic software for different operating systems:

[See documentation](https://install-new-computer.readthedocs.io/en/latest/)

## Installation for users

```
pip install inc
```

## Installation for developers

Copy-paste these 3 lines into a terminal. For example `bash install mac.mk` will run the macOs installer

```
git clone https://github.com/joamatab/install_new_computer.git ~/install_new_computer
cd install_new_computer/bash
bash install mac
```

where you can replace mac.mk by any of the supported OS:

- arch
- centos
- fedora
- mac
- ubuntu

This install the specific `install` section of the Makefile for the selected distro.

To install specific sections of each Makefile you can also run

```
bash install centos desktop
```

For MacOs type this into a terminal

```
xcode-select --install
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
  hello
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

Links:

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
