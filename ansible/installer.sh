#!/bin/bash
set -euo pipefail

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
		driver_system=(
			nvidia-dkms
			nvidia-utils
		lib32-nvidia-utils
		nvidia-settings
		pipewire
		wireplumber
		gwe
		cuda
		sddm
		nm-connection-editor
		egl-wayland
		wl-clipboard
		xdg-desktop-portal-hyprland
		xdg-desktop-portal-gtk
			sysstat
			bluez
			bluez-utils
			gvfs
		)
	ui_desktop=(
		hyprutils
		hyprlang
		hyprland
		hyprpicker
		hyprpolkitagent
		hyprsysteminfo
		grim
		slurp
		gtk3
		nwg-look
		adw-gtk-theme
		font-awesome-5
		ttf-jetbrains-mono-nerd
		maplemono-nf-unhinted
		ttf-hack-nerd
		nerd-fonts-apple
		noctalia-git
	)

	terminal_dev=(
		ghostty
		tmux
		zsh
		neovim
		python-neovim
		git
		git-delta
		lazygit
		docker
		docker-compose
		docker-buildx
		lazydocker
		kubectl
		minikube
		virtualbox
		openvpn
		dbeaver
		postman-bin
		bruno-bin
		fzf
		ripgrep
		fd
		tree
		btop
		sshs
		zoxide
		bluetui
		uv
		pandoc-cli
		texlive-core
		texlive
		just
		github-cli
		tree-sitter-cli
		luarocks
		tldr
		direnv
	)

	gaming=(
		steam
		lutris
		wine
		vulkan-icd-loader
		lib32-vulkan-icd-loader
		gamemode
		lib32-gamemode
		mangohud
		goverlay
		lact
	)

	applications_utilities=(
		nautilus
		yazi
		obsidian
		libreoffice-still
		thunderbird
		thunderbird-i18n
		discord
		zen-browser-bin
		mpv
		spotify-launcher
		ffmpeg
		7zip
		jq
		poppler
		imagemagick
		bazecor
		mission-center
		yt-dlp
		nomacs
		obs-studio
		okular
		gedit
		syncthing
		zip
		unzip
		restic
		localsend
		cryptomator
		cryptomator-cli
		caddy
	)

	if ! command -v yay >/dev/null 2>&1; then
		echo "yay is required on Arch. Run setup.sh first or install yay and rerun this script."
		exit 1
	fi

	for package in "${driver_system[@]}"; do
		yay -S --needed --noconfirm "$package" || echo "$package failed to install"
	done

	for package in "${ui_desktop[@]}"; do
		yay -S --needed --noconfirm "$package" || echo "$package failed to install"
	done

	for package in "${terminal_dev[@]}"; do
		yay -S --needed --noconfirm "$package" || echo "$package failed to install"
	done

	for package in "${gaming[@]}"; do
		yay -S --needed --noconfirm "$package" || echo "$package failed to install"
	done

	for package in "${applications_utilities[@]}"; do
		yay -S --needed --noconfirm "$package" || echo "$package failed to install"
	done

	ansible-galaxy collection install -r "$HOME/dotfiles/ansible/collections.yml"
fi

if [ "$SYSTEM" == "Darwin" ]; then
	if ! command -v brew >/dev/null 2>&1; then
		echo "Homebrew is required on macOS. Install it from https://brew.sh/ and rerun this script."
		exit 1
	fi

	# UI/Desktop (casks)
	brew install --cask \
		raycast \
		font-jetbrains-mono-nerd-font \
		font-maple-mono-nf \
		font-hack-nerd-font \
		font-sf-pro \
		shottr

	# Terminal/Development (casks)
	brew install --cask \
		dbeaver-community \
		postman \
		bruno \
		docker \
		ghostty \
		virtualbox \
		openvpn-connect \
		dotnet-sdk \
		dotnet-sdk@8 \
		cursor

	# Applications/Utilities (casks)
	brew install --cask \
		brave-browser \
		libreoffice \
		discord \
		spotify \
		bazecor \
		obsidian \
		rustdesk

	# Terminal/Development (packages)
	brew install \
		ansible \
		ansible-lint \
		postgresql \
		git \
		gh \
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
		gnu-tar \
		gnu-sed \
		yazi \
		tmux \
		font-symbols-only-nerd-font \
		just \
		tree-sitter-cli \
		luarocks \
		opencode \
		direnv

	# Applications/Utilities (packages)
	brew install \
		ffmpeg \
		sevenzip \
		jq \
		poppler \
		zoxide \
		resvg \
		imagemagick \
		syncthing

	ansible-galaxy collection install -r "$HOME/dotfiles/ansible/collections.yml"

	ansible --version | head -n 1
	ansible-galaxy --version | head -n 1
	gtar --version | head -n 1
fi
