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
		docker
		docker-compose
		docker-buildx
		lazydocker
		virtualbox
		openvpn
		dbeaver
		postman-bin
		bruno-bin
		tree
		btop
		sshs
		bluetui
		pandoc-cli
		texlive-core
		texlive
		luarocks
		tldr
		direnv
		mise
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
	macos_ui_casks=(
		raycast
		font-jetbrains-mono-nerd-font
		font-maple-mono-nf
		font-hack-nerd-font
		font-sf-pro
		shottr
		nikitabobko/tap/aerospace # Tiling window manager used by the macOS configuration
		font-symbols-only-nerd-font # Symbols used by terminal and status bar themes
	)
	brew install --cask "${macos_ui_casks[@]}"

	# Terminal/Development (casks)
	macos_dev_casks=(
		dbeaver-community
		postman
		bruno
		docker
		ghostty
		virtualbox
		openvpn-connect
		cursor
		visual-studio-code # Code editor
		claude-code # Claude coding assistant CLI
		gcloud-cli # Google Cloud CLI
		basictex # LaTeX tools for document and PDF generation
	)
	brew install --cask "${macos_dev_casks[@]}"

	# Applications/Utilities (casks)
	macos_app_casks=(
		brave-browser
		libreoffice
		discord
		spotify
		bazecor
		obsidian
		rustdesk
		bitwarden # Password manager
		cryptomator # Encrypted vaults for cloud files
		localsend # Local network file transfer
		obs # Screen recording and streaming
		vlc # Media player
		slack # Team messaging
		zoom # Video meetings
		chatgpt # ChatGPT desktop app
		balenaetcher # Write operating system images to USB drives
	)
	brew install --cask "${macos_app_casks[@]}"

	# Terminal/Development (packages)
	macos_dev_packages=(
		ansible
		ansible-lint
		postgresql
		git
		openvpn
		neovim
		zsh
		btop
		sshs
		gnu-tar
		gnu-sed
		tmux
		mise # Tools and runtimes declared in mise/config.toml
		luarocks
		opencode
		direnv
		awscli # AWS CLI
		argocd # Argo CD deployment CLI
		k9s # Terminal Kubernetes dashboard
		docker-compose # Docker Compose CLI
		lazydocker # Terminal Docker dashboard
		k6 # Load testing CLI
		pyenv # Python version manager
		poetry # Python project and dependency manager
		redis # Local Redis server
		mysql-client # MySQL client tools
		libpq # PostgreSQL client tools
		sqlcmd # SQL Server CLI
		bat # File viewer with syntax highlighting
		tree # Directory tree viewer
		wget # Command-line file downloader
		nmap # Network discovery and port scanning
		zsh-completions # Additional Zsh completions
	)
	brew install "${macos_dev_packages[@]}"

	# Applications/Utilities (packages)
	macos_utility_packages=(
		ffmpeg
		sevenzip
		poppler
		resvg
		imagemagick
		syncthing
		felixkratz/formulae/sketchybar # Status bar used by the macOS configuration
		switchaudio-osx # Audio device control used by SketchyBar
		terminal-notifier # Send macOS notifications from scripts
		pandoc # Document format converter
		ncdu # Interactive disk usage viewer
		unzip # Extract ZIP archives
	)
	brew install "${macos_utility_packages[@]}"

	ansible-galaxy collection install -r "$HOME/dotfiles/ansible/collections.yml"

	ansible --version | head -n 1
	ansible-galaxy --version | head -n 1
	gtar --version | head -n 1
fi
