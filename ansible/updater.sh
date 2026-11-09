#!/bin/bash
# No `set -e` on purpose: one failing updater should not skip the others.
set -uo pipefail

SYSTEM=""

if [ "$(uname)" == "Darwin" ]; then
	SYSTEM="Darwin"
elif [ "$(uname -s)" == "Linux" ]; then
	if [ -f /etc/arch-release ]; then
		SYSTEM="Arch"
	fi
fi

if [ "$SYSTEM" == "Arch" ]; then
	yay -Syu --noconfirm
fi

if [ "$SYSTEM" == "Darwin" ]; then
	brew update && brew upgrade
fi

if command -v mise >/dev/null 2>&1; then
	mise upgrade --yes
fi

ZSH="${ZSH:-$HOME/.oh-my-zsh}"

if [ -x "$ZSH/tools/upgrade.sh" ]; then
	"$ZSH/tools/upgrade.sh"
else
	echo "Oh My Zsh not found in $ZSH, skipping its upgrade."
fi
