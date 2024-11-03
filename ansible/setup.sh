#!/bin/bash

git clone https://github.com/Isur/dotfiles ~/dotfiles
yay -S ansible --noconfirm
(cd ~/dotfiles && ansible-playbook -i inventory.yaml play.yaml -K)

