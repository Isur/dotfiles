#!/bin/bash

REPO_URL="https://github.com/Isur/dotfiles.git"
DOTFILES=$HOME/dotfiles
ANSIBLE_DIR=$DOTFILES/ansible
BRANCH=master
SYSTEM=""

if [ "$(uname)" == "Darwin" ]; then
	SYSTEM="Darwin"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	if [ -f /etc/arch-release ]; then
		SYSTEM="Arch"
	fi
fi

if [ "$SYSTEM" == "" ]; then
    echo "System not supported. Script will work only on Arch based system or MacOS (Darwin)"
	exit 1
fi


if [ "$SYSTEM" == "Arch" ]; then
	if ! command -v yay &> /dev/null
	then
		sudo pacman -S --needed git base-devel --noconfirm
		rm -rf yay
		git clone https://aur.archlinux.org/yay.git
		cd yay
		makepkg -si
		cd ..
		rm -rf yay
	fi

	yay -S --noconfirm ansible python-psycopg2
fi

if [ "$SYSTEM" == "Darwin" ]; then
	which -s brew
	if [[ $? != 0 ]] ; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	else
		brew update
	fi

	brew install ansible
	brew install postgresql
fi

git clone $REPO_URL $DOTFILES

(
	cd $DOTFILES && \
	git checkout $BRANCH && \
	cd $ANSIBLE_DIR && \
	ansible-galaxy install -r collections.yml && \
	ansible-playbook play.yml -i inventory.yml -K --vault-password-file ~/.vault_pass && \
	echo DONE
)
