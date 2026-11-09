#!/bin/bash
set -euo pipefail

REPO_URL="https://github.com/Isur/dotfiles.git"
DOTFILES="$HOME/dotfiles"
ANSIBLE_DIR="$DOTFILES/ansible"
BRANCH=master
SYSTEM=""

if [ "$(uname)" == "Darwin" ]; then
	SYSTEM="Darwin"
elif [ "$(uname -s)" == "Linux" ]; then
	if [ -f /etc/arch-release ]; then
		SYSTEM="Arch"
	fi
fi

if [ -z "$SYSTEM" ]; then
	echo "System not supported. Script will work only on Arch based system or MacOS (Darwin)"
	exit 1
fi

# Put Homebrew on PATH for this shell (fresh installs are not on PATH yet).
load_brew() {
	local brew_bin
	for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew; do
		if [ -x "$brew_bin" ]; then
			eval "$("$brew_bin" shellenv)"
			return 0
		fi
	done
	return 1
}

if [ "$SYSTEM" == "Arch" ]; then
	if ! command -v yay >/dev/null 2>&1; then
		sudo pacman -S --needed git base-devel --noconfirm
		rm -rf yay
		git clone https://aur.archlinux.org/yay.git
		cd yay
		makepkg -si --noconfirm
		cd ..
		rm -rf yay
	fi

	yay -S --needed --noconfirm ansible python-psycopg2
fi

if [ "$SYSTEM" == "Darwin" ]; then
	command -v brew >/dev/null 2>&1 || load_brew || true

	if ! command -v brew >/dev/null 2>&1; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		load_brew || { echo "Homebrew installed but brew binary not found."; exit 1; }
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
