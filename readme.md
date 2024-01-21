# Dotfiles

Dotfiles that are included here with auto installation of everything that is needed.

Systems that are supported:

- arch based
- debian based
- mac os

Tested on:

- manjaro
- endeavouros
- ubuntu
- mac os

## Includes

Configs in this repo:

- tmux
- neovim
- btop
- zsh
- kitty
- git
- lazygit
- ideavim
- vscode
- ssh

## Requirements

- `sudo` privileges.
- `git` installed.
- `.vault_pass` file with password (required for ssh setup)

## Installing

Install script will install:

- `tmux`
- `neovim`
- `ripgrep`
- `lazygit`
- `git-delta`
- `btop`
- `fzf`
- `fd`
- `kitty`
- `zsh`
- `gnu-sed`
- `ansible`
- ssh configs
- Directory structure
- `node`, `npm`, `pnpm`
- `docker`

Package manager used for installing depends on system:

- macos - `homebrew`
- debian based - `apt` and `snap`
- arch based - `yay`

## Helpers

`./install.sh` - will install everything thats needed and configure symlinks.

## Preview

![Preview](./preview.jpeg)
