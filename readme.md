# Dotfiles

Dotfiles here includes everything I need on my machines.

Everything is collected into ansible playbook and roles.

Two playbooks:
- `play.yml` - install and setup everything
- `repos.yml` - just clone some personal repositories

## Supported systems

- arch based;
- mac os (darwin);

### Tested on

- endeavouros;
- mac os;

## Includes

- dotfiles (configs);
- scripts;
- applications installation;
- secrets;
- wallpapers;

### Scripts

Those scripts will be installed:

- `keker` - automatically create directory for new project - template might be used for this;
- `updater` - update dotfiles repo, packages with `yay`/`brew`/`apt` and `Oh My ZSH`;
- `tmux-sessionizer` - create tmux session in selected directory;

### Secrets

Hidden with `ansible-vault`:
- `ssh` - keys;

## Requirements

- `sudo` privileges;
- `.vault_pass` file with password (required for ssh and other secrets) in `$HOME/.vault_pass`;


## Helpers

- `./server.sh` - will install some tools that I use on servers;
- `./setup.sh` - will install what is required for personal use and run ansible with everything;

### Personal
Run this script to setup personal machine.

```sh
bash -c "$(curl https://raw.githubusercontent.com/Isur/dotfiles/refs/heads//ansible/setup.sh)"
```

### Server

Install some tools that I use on servers:

```sh
bash -c "$(curl https://raw.githubusercontent.com/isur/dotfiles/master/install/server.sh)"
```

## Preview
i3wm

![Preview](./i3wm.png)
