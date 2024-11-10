#!/bin/bash

REPO_URL="https://github.com/Isur/dotfiles.git"
DOTFILES="$HOME/dotfiles"
ANSIBLE_DIR="$HOME/dotfiles/ansible"
REQUIREMENTS_FILE="$ANSIBLE_DIR/collections.yaml"

git clone $REPO_URL $DOTFILES

(cd $ANSIBLE_DIR && ansible-galaxy install -r collections.yaml)
(cd $ANSIBLE_DIR && ansible-playbook play.yaml -i inventory.yaml -K --vault-password-file $HOME/.vault_pass)
