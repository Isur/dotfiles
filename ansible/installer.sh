#!/bin/bash
# Keep this script compatible with macOS' bash 3.2.
set -euo pipefail

SYSTEM=""
FAILED=()

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

# Install a whole group in one go; if that fails, retry package by package
# so one broken/renamed package does not block the rest. Failures are
# collected and reported at the end.
yay_install() {
	local group="$1"
	shift
	echo "==> [$group] installing $# packages"
	if yay -S --needed --noconfirm "$@"; then
		return 0
	fi
	echo "==> [$group] batch install failed, retrying one by one"
	local package
	for package in "$@"; do
		yay -S --needed --noconfirm "$package" || FAILED+=("$package")
	done
}

brew_install() {
	local kind="$1" group="$2"
	shift 2
	local flags=()
	if [ "$kind" == "cask" ]; then
		flags=(--cask)
	fi
	echo "==> [$group] installing $# packages"
	if brew install ${flags[@]+"${flags[@]}"} "$@"; then
		return 0
	fi
	echo "==> [$group] batch install failed, retrying one by one"
	local package
	for package in "$@"; do
		brew install ${flags[@]+"${flags[@]}"} "$package" || FAILED+=("$package")
	done
}

report_failures() {
	if [ "${#FAILED[@]}" -eq 0 ]; then
		echo "==> All packages installed"
		return 0
	fi
	echo
	echo "==> WARNING: ${#FAILED[@]} package(s) failed to install:"
	local package
	for package in "${FAILED[@]}"; do
		echo "    - $package"
	done
	echo
}

if [ "$SYSTEM" == "Arch" ]; then
	if ! command -v yay >/dev/null 2>&1; then
		echo "yay is required on Arch. Run setup.sh first or install yay and rerun this script."
		exit 1
	fi

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

	# nvidia-dkms builds against the headers of every installed kernel.
	for kernel in linux linux-lts linux-zen linux-hardened; do
		if pacman -Q "$kernel" >/dev/null 2>&1; then
			driver_system+=("$kernel-headers")
		fi
	done

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
		brave-bin
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

	yay_install "drivers/system" "${driver_system[@]}"
	yay_install "ui/desktop" "${ui_desktop[@]}"
	yay_install "terminal/dev" "${terminal_dev[@]}"
	yay_install "gaming" "${gaming[@]}"
	yay_install "applications/utilities" "${applications_utilities[@]}"

	report_failures
fi

if [ "$SYSTEM" == "Darwin" ]; then
	if ! command -v brew >/dev/null 2>&1; then
		for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew; do
			if [ -x "$brew_bin" ]; then
				eval "$("$brew_bin" shellenv)"
				break
			fi
		done
	fi

	if ! command -v brew >/dev/null 2>&1; then
		echo "Homebrew is required on macOS. Install it from https://brew.sh/ and rerun this script."
		exit 1
	fi

	brew_install cask "ui/desktop" \
		raycast \
		font-jetbrains-mono-nerd-font \
		font-maple-mono-nf \
		font-hack-nerd-font \
		font-sf-pro \
		font-symbols-only-nerd-font \
		shottr \
		nikitabobko/tap/aerospace

	brew_install cask "terminal/dev" \
		dbeaver-community \
		postman \
		bruno \
		docker \
		ghostty \
		visual-studio-code \
		claude-code \
		gcloud-cli \
		basictex \
		virtualbox \
		openvpn-connect

	brew_install cask "applications/utilities" \
		brave-browser \
		libreoffice \
		discord \
		spotify \
		bazecor \
		obsidian \
		bitwarden \
		cryptomator \
		localsend \
		obs \
		vlc \
		slack \
		zoom \
		chatgpt \
		balenaetcher \
		rustdesk

	brew_install formula "ui/desktop" \
		FelixKratz/formulae/sketchybar

	brew_install formula "terminal/dev" \
		ansible \
		ansible-lint \
		postgresql \
		git \
		openvpn \
		neovim \
		awscli \
		argocd \
		k9s \
		docker-compose \
		k6 \
		pyenv \
		poetry \
		redis \
		mysql-client \
		libpq \
		sqlcmd \
		bat \
		tree \
		wget \
		nmap \
		zsh-completions \
		zsh \
		btop \
		sshs \
		gnu-tar \
		gnu-sed \
		tmux \
		luarocks \
		direnv \
		mise

	brew_install formula "applications/utilities" \
		ffmpeg \
		sevenzip \
		poppler \
		switchaudio-osx \
		terminal-notifier \
		pandoc \
		ncdu \
		unzip \
		resvg \
		imagemagick \
		syncthing

	brew services start sketchybar || FAILED+=("sketchybar (service start)")

	ansible --version | head -n 1
	gtar --version | head -n 1
	report_failures
fi
