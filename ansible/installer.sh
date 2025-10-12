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
		nm-connection-editor
		gvfs
	)
	ui_desktop=(
		hyprutils
		hyprlang
		hyprland
		hyprpaper
		hyprlock
		hypridle
		hyprpicker
		hyprpolkitagent
		hyprsysteminfo
		hyprnotify
		waybar
		rofi
		grim
		slurp
		gtk-layer-shell
		gtk3
		nwg-look
		adw-gtk-theme
		font-awesome-5
		ttf-jetbrains-mono-nerd
		maplemono-nf-unhinted
		ttf-hack-nerd
		apple-fonts
		nerd-fonts-apple
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
	)

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
fi

if [ "$SYSTEM" == "Darwin" ]; then
	# UI/Desktop (casks)
	brew install --cask \
		raycast \
		font-jetbrains-mono-nerd-font \
		font-maple-mono-nf \
		font-hack-nerd-font \
		font-sf-pro

	# Terminal/Development (casks)
	brew install --cask \
		dbeaver-community \
		postman \
		bruno \
		docker \
		ghostty \
		virtualbox \
		openvpn-connect

	# Applications/Utilities (casks)
	brew install --cask \
		arc \
		zen \
		discord \
		spotify \
		bazecor \
		obsidian

	# Terminal/Development (packages)
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
		tmux \
		font-symbols-only-nerd-font \
		just

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
fi
