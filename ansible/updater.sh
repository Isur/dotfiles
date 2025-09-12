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

$ZSH/tools/upgrade.sh
