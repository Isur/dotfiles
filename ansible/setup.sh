#!/bin/bash

yay -S git ansible --noconfirm

REPO_URL="https://github.com/Isur/dotfiles.git"
DOTFILES="$HOME/dotfiles"
ANSIBLE_DIR="$HOME/dotfiles/ansible"

git clone $REPO_URL $DOTFILES

(cd $ANSIBLE_DIR && ansible-galaxy install -r collections.yml)
(cd $ANSIBLE_DIR && ansible-playbook play.yaml -i inventory.yml -K --vault-password-file $HOME/.vault_pass)
