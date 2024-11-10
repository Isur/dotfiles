#!/bin/bash

yay -S git ansible --noconfirm

REPO_URL="https://github.com/Isur/dotfiles.git"
DOTFILES="$HOME/dotfiles"
ANSIBLE_DIR="$HOME/dotfiles/ansible"
BRANCH=ansible

git clone $REPO_URL $DOTFILES

(cd $DOTFILES &&\
    git checkout $BRANCH &&\
    cd $ANSIBLE_DIR &&\
    ansible-galaxy install -r collections.yml &&\
    ansible-playbook play.yml -i inventory.yml -K --vault-password-file $HOME/.vault_pass)
