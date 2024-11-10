#!/bin/bash

yay -S git ansible --noconfirm

git clone https://github.com/Isur/dotfiles ~/dotfiles

(cd ~/dotfiles && git checkout ansible && cd ~/dotfiles/ansible && ansible-galaxy install -r collections.yaml && ansible-playbook play.yaml -i inventory.yaml -K --vault-password-file=$HOME/.vault_pass)
