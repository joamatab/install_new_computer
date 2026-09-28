# CHANGELOG

<!-- towncrier release notes start -->

## [0.1.20](https://github.com/joamatab/install_new_computer/releases/tag/v0.1.20) - 2026-09-28

- Remove optional `s3fs` from the default Mac package list so S3 mounting support cannot block computer setup.
- Add a regression test that completes the default package installation when `s3fs` is unavailable.

## [0.1.19](https://github.com/joamatab/install_new_computer/releases/tag/v0.1.19) - 2026-09-28

- Authenticate sudo upfront, refresh authorization during long Mac installations, and clean up background processes on exit.
- Run Oh My Fish without opening an interactive shell, preserve existing installations and plugins, and report download or installation failures.
- Stop setup on failed package or dotfiles steps instead of reporting success.
- Support setup and home directories containing spaces, and load newly installed Homebrew into subsequent steps.
- Add isolated Mac setup regression tests with local Git repositories and a real Fish argument check.

## [0.1.18](https://github.com/joamatab/install_new_computer/releases/tag/v0.1.18) - 2026-09-28

- Run the Homebrew installer in noninteractive mode for admin users.
- Remove `ag` from the default Homebrew package list.
- Disable Antigravity in the default Homebrew Cask app list.


## [0.1.17](https://github.com/joamatab/install_new_computer/releases/tag/v0.1.17) - 2026-08-27

No significant changes.


## [0.1.16](https://github.com/joamatab/install_new_computer/releases/tag/v0.1.16) - 2026-08-27

No significant changes.


## [0.1.15](https://github.com/joamatab/install_new_computer/releases/tag/v0.1.15) - 2026-08-25

No significant changes.


## [0.1.14](https://github.com/joamatab/install_new_computer/releases/tag/v0.1.14) - 2026-08-24

No significant changes.


## [0.1.13](https://github.com/joamatab/install_new_computer/releases/tag/v0.1.13) - 2026-02-27

No significant changes.


## [0.1.12](https://github.com/joamatab/install_new_computer/releases/tag/v0.1.12) - 2026-02-27

No significant changes.


## [0.1.11](https://github.com/joamatab/install_new_computer/releases/tag/v0.1.11) - 2026-02-27

No significant changes.


## [0.1.10](https://github.com/joamatab/install_new_computer/releases/tag/v0.1.10) - 2026-02-27

No significant changes.


## [0.1.9](https://github.com/joamatab/install_new_computer/releases/tag/v0.1.9) - 2026-02-20

No significant changes.


## [0.1.8](https://github.com/joamatab/install_new_computer/releases/tag/v0.1.8) - 2026-02-19

- Add autocomplete [#18](https://github.com/joamatab/install_new_computer/pull/#18)
- test brew [#17](https://github.com/joamatab/install_new_computer/pull/#17)
- add more bash scripts [#16](https://github.com/joamatab/install_new_computer/pull/#16)

## [0.1.7](https://github.com/joamatab/install_new_computer/releases/tag/v0.1.7) - 2025-12-19

No significant changes.


## [0.1.6](https://github.com/joamatab/install_new_computer/releases/tag/v0.1.6) - 2025-06-30

No significant changes.


## [0.1.5](https://github.com/joamatab/install_new_computer/releases/tag/v0.1.5) - 2025-06-30

No significant changes.


## [0.1.4](https://github.com/joamatab/install_new_computer/releases/tag/v0.1.4) - 2025-06-30

No significant changes.


## [0.1.3](https://github.com/joamatab/install_new_computer/releases/tag/v0.1.3) - 2025-06-30

No significant changes.


## [0.1.2](https://github.com/joamatab/install_new_computer/releases/tag/v0.1.2) - 2025-06-30

No significant changes.


## [0.1.1](https://github.com/joamatab/install_new_computer/releases/tag/v0.1.1) - 2024-12-17

No significant changes.


## [0.1.0](https://github.com/joamatab/install_new_computer/releases/tag/v0.1.0) - 2024-12-14

- add ssh key [#8](https://github.com/joamatab/install_new_computer/pull/#8)
