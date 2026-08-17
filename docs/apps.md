# Install applications

`inc` can install individual command-line applications with the native package
manager for your operating system. Application names, executable checks, and
package mappings live in `inc/apps.toml`, so the same command works across
supported computers.

## Discover applications

Run `inc apps` to see the detected platform, available applications, package
names, and whether each command is installed:

```console
$ inc apps
Platform: arch
Applications:
  gh           missing   github-cli               GitHub CLI
  git          installed git                      Git version control
  curl         installed curl                     Command-line data transfer tool
  ripgrep      installed ripgrep                  Fast recursive text search
  fzf          installed fzf                      Command-line fuzzy finder
  just         installed just                     Command runner for project recipes
  shellcheck   missing   shellcheck               Shell script analyzer
  node         installed nodejs                   Node.js JavaScript runtime
Profiles:
  core         gh, git, curl, ripgrep, fzf
  dev          gh, git, curl, ripgrep, fzf, just, shellcheck, node
```

Check everything or only selected applications without changing the computer:

```bash
inc apps status
inc apps status gh shellcheck
```

## Install an application

Preview the native command first:

```console
$ inc apps install gh --dry-run
gh: sudo pacman -S --needed --noconfirm github-cli
```

Then install it. `inc` asks for confirmation, invokes the native package
manager, and verifies the resulting executable with `--version`:

```bash
inc apps install gh
```

Pass `--yes` or `-y` to skip the `inc` confirmation prompt:

```bash
inc apps install gh --yes
```

After installing GitHub CLI, `inc` prints the authentication step:

```bash
gh auth login
```

## Use the familiar `inc run` flow

Catalog applications also appear alongside scripts in `inc ls` and the
`inc run` completion list. This keeps the original short workflow:

```bash
inc run gh --dry-run
inc run gh
inc run gh --yes
```

If a shell script and catalog application have the same name, the existing
shell script takes precedence.

## Install a profile

Profiles install a useful group of applications. Already-installed commands
are skipped automatically, and duplicate entries are removed:

```bash
inc apps install --profile core
inc apps install --profile dev --yes
```

The included profiles are:

| Profile | Applications |
| --- | --- |
| `core` | `gh`, `git`, `curl`, `ripgrep`, `fzf` |
| `dev` | core apps plus `just`, `shellcheck`, and `node` |

## Shell completion

Install completion once, then restart the shell:

```bash
inc --install-completion
```

Application and profile names can then be completed with Tab:

```text
inc run g<Tab>
inc apps install g<Tab>
inc apps status sh<Tab>
inc apps install --profile d<Tab>
```

## Supported package managers

| Platform family | Package manager |
| --- | --- |
| Arch and Manjaro | `pacman` |
| Debian and Ubuntu | `apt-get` |
| Fedora, RHEL, and CentOS | `dnf` |
| openSUSE | `zypper` |
| macOS | Homebrew |
| Windows | WinGet |

Run `inc doctor` to check catalog loading, platform detection, the native
package manager, the global `inc` command, and GitHub authentication when `gh`
is present.

## Add an application

Add a section to `inc/apps.toml`. The `command` is the executable used for
status and post-install verification; platform fields are native package names:

```toml
[apps.example]
description = "Example command-line application"
command = "example"
arch = "example"
debian = "example"
fedora = "example"
opensuse = "example"
macos = "example"
windows = "Publisher.Example"
post_install = ["example", "configure"]
```

Platform fields may be omitted when an application is not supported there.
Add the application name to a list under `[profiles]` if it belongs in a
profile. Catalog validation rejects profiles that refer to unknown apps.

## Test a development checkout globally

Install this checkout in editable mode so changes are immediately visible from
other directories and terminal tabs:

```bash
just tool-install
just tool-check
```

Remove it later with `just tool-uninstall`.
