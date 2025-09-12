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
	# NVIDIA drivers
	yay -S --needed --noconfirm \
		nvidia-dkms \
		nvidia-utils \
		lib32-nvidia-utils \
		nvidia-settings

	# Hyprland window manager
	yay -S --needed --noconfirm \
		hyprland \
		hyprpaper \
		hyprlock \
		hypridle \
		hyprpicker \
		hyprpolkitagent \
		hyprsysteminfo \
		hyprnotify

	# Wayland support
	yay -S --needed --noconfirm \
		egl-wayland \
		xdg-desktop-portal-hyprland \
		xdg-desktop-portal-gtk \
		pipwewire \
		wireplumber

	# UI/Desktop tools
	yay -S --needed --noconfirm \
		waybar \
		rofi \
		sddm \
		grim \
		slurp \
		flameshot \
		nm-connection-editor \
		mission-center

	# GTK/Theming
	yay -S --needed --noconfirm \
		gtk-layer-shell \
		gtk3 \
		nwg-look

	# File managers
	yay -S --needed --noconfirm \
		nautilus \
		yazi

	# Fonts
	yay -S --needed --noconfirm \
		font-awesome-5 \
		ttf-jetbrains-mono-nerd \
		ttf-maple

	# Productivity apps
	yay -S --needed --noconfirm \
		obsidian \
		libreoffice-still \
		thunderbird \
		thunderbird-i18n

	# Communication/Social
	yay -S --needed --noconfirm \
		discord \
		zen-browser-bin

	# Media/Entertainment
	yay -S --needed --noconfirm \
		mpv \
		spotify-launcher

	# Gaming
	yay -S --needed --noconfirm \
		steam \
		lutris \
		wine \
		vulkan-icd-loader \
		lib32-vulkan-icd-loader \
		gamemode \
		lib32-gamemode

	# Development tools
	yay -S --needed --noconfirm \
		dbeaver \
		postman-bin \
		bruno-bin

	# Virtualization
	yay -S --needed --noconfirm \
		virtualbox \
		openvpn

	# Containerization
	yay -S --needed --noconfirm \
		docker \
		docker-compose \
		docker-buildx \
		lazydocker

	# Kubernetes
	yay -S --needed --noconfirm \
		kubectl \
		minikube

	# Version control
	yay -S --needed --noconfirm \
		git \
		git-delta \
		lazygit

	# Terminal/CLI tools
	yay -S --needed --noconfirm \
		ghostty \
		tmux \
		zsh \
		fzf \
		ripgrep \
		fd \
		btop \
		sshs \
		zoxide

	# Text editor
	yay -S --needed --noconfirm \
		neovim \
		python-neovim

	# Programming languages/tools
	yay -S --needed --noconfirm \
		uv

	# Utilities
	yay -S --needed --noconfirm \
		sysstat \
		gvfs \
		ffmpeg \
		7zip \
		jq \
		poppler \
		imagemagick \
		bazecor
fi

if [ "$SYSTEM" == "Darwin" ]; then
	brew install --cask  \
		dbeaver-community \
		postman \
		virtualbox\
		openvpn-connect\
		bruno \
		docker \
		ghostty \
		arc \
		discord \
		spotify \
		bazecor \
		obsidian \
		raycast \
		font-jetbrains-mono-nerd-font \
		font-maple-mono-nf \
		font-hack-nerd-font \
		font-sf-pro

	brew install \
		postgresql@17 \
		git \
		openvpn \
		lazygit \
		git-delta \
		kubernetes-cli \
		minikube \
		neovim \
		uv \
		zsh \
		fzf \
		ripgrep \
		fd \
		btop \
		sshs \
		gnu-sed \
		yazi \
		ffmpeg \
		sevenzip \
		jq \
		poppler \
		zoxide \
		resvg \
		imagemagick \
		font-symbols-only-nerd-font \
		tmux
fi
