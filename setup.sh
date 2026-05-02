#!/bin/bash
set -euo pipefail

REPO_URL="https://github.com/Isur/dotfiles.git"
DOTFILES="$HOME/dotfiles"
ANSIBLE_DIR="$DOTFILES/ansible"
BRANCH=master
SYSTEM=""

if [ "$(uname)" == "Darwin" ]; then
	SYSTEM="Darwin"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	if [ -f /etc/arch-release ]; then
		SYSTEM="Arch"
	fi
fi

if [ -z "$SYSTEM" ]; then
    echo "System not supported. Script will work only on Arch based system or MacOS (Darwin)"
	exit 1
fi


if [ "$SYSTEM" == "Arch" ]; then
	if ! command -v yay >/dev/null 2>&1; then
		sudo pacman -S --needed git base-devel --noconfirm
		rm -rf yay
		git clone https://aur.archlinux.org/yay.git
		cd yay
		makepkg -si
		cd ..
		rm -rf yay
	fi

	yay -S --needed --noconfirm ansible python-psycopg2
fi

if [ "$SYSTEM" == "Darwin" ]; then
	which -s brew
	if [[ $? != 0 ]] ; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	else
		brew update
	fi
fi

if [ ! -d "$DOTFILES" ]; then
	git clone "$REPO_URL" "$DOTFILES"
elif [ -d "$DOTFILES/.git" ]; then
	git -C "$DOTFILES" fetch --all --prune
else
	echo "Directory $DOTFILES exists but is not a git repository. Please move/remove it and rerun."
	exit 1
fi

if [ ! -f "$HOME/.vault_pass" ]; then
	echo "Missing $HOME/.vault_pass. Create it before running setup (required for ansible-vault secrets)."
	exit 1
fi

(
	cd "$DOTFILES" && \
	git checkout "$BRANCH" && \
	git pull --ff-only origin "$BRANCH" && \
	cd "$ANSIBLE_DIR" && \
	./installer.sh && \
	ansible-playbook play.yml -i inventory.yml -K --vault-password-file "$HOME/.vault_pass" && \
	echo DONE
)
