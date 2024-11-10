#!/bin/bash

yay -S git ansible --noconfirm

REPO_URL="https://github.com/Isur/dotfiles.git"
DOTFILES="$HOME/dotfiles"
ANSIBLE_DIR="$HOME/dotfiles/ansible"
BRANCH=ansible

git clone $REPO_URL $DOTFILES

(cd $ANSIBLE_DIR &&\
    git checkout $BRANCH &&\
    ansible-galaxy install -r collections.yml &&\
    ansible-playbook play.yml -i inventory.yml -K --vault-password-file $HOME/.vault_pass)
