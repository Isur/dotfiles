#!/bin/bash
SYSTEM=""

if [ "$(uname)" == "Darwin" ]; then
	SYSTEM="Darwin"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
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

if [ "$ZSH" == "" ]; then
	ZSH="$HOME/.oh-my-zsh"
fi

$ZSH/tools/upgrade.sh

