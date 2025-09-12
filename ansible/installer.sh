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
	# General apps
	yay -S --needed --noconfirm \
		sysstat \
		gvfs \
		font-awesome-5 \
		ttf-jetbrains-mono-nerd \
		ttf-maple \
		mpv \
		bazecor \
		thunderbird \
		thunderbird-i18n \
		spotify-launcher \
		obsidian \
		discord \
		zen-browser-bin \
		thunar \
		flameshot \
		libreoffice-still

	# hyprland stuff
	yay -S --needed --noconfirm \
		hyprland \
		nvidia-dkms \
		nvidia-utils \
		lib32-nvidia-utils \
		egl-wayland \
		hyprpaper \
		hyprlock \
		hypridle \
		hyprpicker \
		hyprpolkitagent \
		hyprsysteminfo \
		hyprnotify \
		xdg-desktop-portal-hyprland \
		xdg-desktop-portal-gtk \
		pipwewire \
		wireplumber \
		grim \
		slurp \
		waybar \
		nm-connection-editor \
		gtk-layer-shell \
		gtk3 \
		nwg-look \
		rofi \
		nautilus \
		sddm \
		mission-center

	yay -S --needed --noconfirm \
		dbeaver \
		postman-bin \
		virtualbox \
		openvpn \
		bruno-bin

	yay -S --needed --noconfirm \
		docker \
		docker-compose \
		docker-buildx \
		lazydocker

	yay -S --needed --noconfirm \
		git \
		git-delta \
		lazygit

	yay -S --needed --noconfirm \
		kubectl \
		minikube

	yay -S --needed --noconfirm \
		neovim \
		python-neovim \
		tmux

	yay -S --needed --noconfirm \
		uv \
		zsh

	yay -S --needed --noconfirm \
		fzf \
		ripgrep \
		fd \
		btop \
		sshs \
		ghostty \
		yazi \
		ffmpeg \
		7zip \
		jq \
		poppler \
		zoxide \
		imagemagick

	yay -S --needed --noconfirm \
		wine \
		steam \
		lutris \
		nvidia-dkms \
		nvidia-utils \
		lib32-nvidia-utils \
		nvidia-settings \
		vulkan-icd-loader \
		lib32-vulkan-icd-loader \
		gamemode \
		lib32-gamemode
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
