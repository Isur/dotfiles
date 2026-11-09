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

BREW_CASKS=""
BREW_FORMULAE=""
EXTERNAL=()

# Snapshot what Homebrew already manages, so those packages are skipped.
load_brew_installed() {
	BREW_CASKS="$(brew list --cask -1 2>/dev/null || true)"
	BREW_FORMULAE="$(brew list --formula -1 2>/dev/null || true)"
}

in_list() {
	printf '%s\n' "$2" | grep -qxF -- "$1"
}

# Succeeds when every App/Font artifact of the cask already exists on disk,
# i.e. it was installed outside Homebrew (manual download, App Store, ...).
# Casks without App/Font artifacts (pkg installers, binaries) can't be
# detected and are left to brew.
cask_present_outside_brew() {
	local cask="$1" info artifacts line name found=0
	info="$(brew info --cask "$cask" 2>/dev/null)" || return 1
	artifacts="$(printf '%s\n' "$info" | awk '/^==> Artifacts/ {a=1; next} /^==> / {a=0} a')"
	while IFS= read -r line; do
		case "$line" in
			*" (App)")
				name="${line% (App)}"
				name="${name##*-> }"
				name="${name##*/}"
				[ -d "/Applications/$name" ] || [ -d "$HOME/Applications/$name" ] || return 1
				found=1
				;;
			*" (Font)")
				name="${line% (Font)}"
				name="${name##*/}"
				[ -f "$HOME/Library/Fonts/$name" ] || [ -f "/Library/Fonts/$name" ] || return 1
				found=1
				;;
		esac
	done <<EOF
$artifacts
EOF
	[ "$found" -eq 1 ]
}

brew_install() {
	local kind="$1" group="$2"
	shift 2
	local flags=() to_install=() package short
	if [ "$kind" == "cask" ]; then
		flags=(--cask)
	fi

	for package in "$@"; do
		short="${package##*/}"
		if [ "$kind" == "cask" ]; then
			if in_list "$short" "$BREW_CASKS"; then
				continue
			elif cask_present_outside_brew "$package"; then
				echo "==> [$group] $package: already installed outside Homebrew, skipping"
				EXTERNAL+=("$package")
				continue
			fi
		elif in_list "$short" "$BREW_FORMULAE"; then
			continue
		fi
		to_install+=("$package")
	done

	if [ "${#to_install[@]}" -eq 0 ]; then
		echo "==> [$group] all $# packages already installed"
		return 0
	fi

	echo "==> [$group] installing ${#to_install[@]} of $# packages: ${to_install[*]}"
	if brew install ${flags[@]+"${flags[@]}"} "${to_install[@]}"; then
		return 0
	fi
	echo "==> [$group] batch install failed, retrying one by one"
	for package in "${to_install[@]}"; do
		brew install ${flags[@]+"${flags[@]}"} "$package" || FAILED+=("$package")
	done
}

report_failures() {
	local package
	if [ "${#EXTERNAL[@]}" -gt 0 ]; then
		echo
		echo "==> Note: ${#EXTERNAL[@]} cask(s) found installed outside Homebrew (not managed/updated by brew):"
		for package in "${EXTERNAL[@]}"; do
			echo "    - $package"
		done
	fi
	if [ "${#FAILED[@]}" -eq 0 ]; then
		echo "==> All packages installed"
		return 0
	fi
	echo
	echo "==> WARNING: ${#FAILED[@]} package(s) failed to install:"
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

	# NVIDIA (open kernel modules, Turing+). Kernel modules are added per kernel below.
	driver_system=(
		nvidia-utils
		lib32-nvidia-utils
		nvidia-settings
		pipewire
		wireplumber
		gwe
		cuda
		sddm
		nm-connection-editor
		wl-clipboard
		xdg-desktop-portal-hyprland
		xdg-desktop-portal-gtk
		sysstat
		bluez
		bluez-utils
		gvfs
	)

	# Headers for every installed kernel (needed by DKMS modules, e.g. virtualbox-host-dkms).
	# NVIDIA: prebuilt modules exist for linux / linux-lts; any other kernel needs
	# nvidia-open-dkms, which conflicts with the prebuilt ones, so use it for all.
	nvidia_modules=()
	nvidia_needs_dkms=false
	for kernel in linux linux-lts linux-zen linux-hardened; do
		if pacman -Q "$kernel" >/dev/null 2>&1; then
			driver_system+=("$kernel-headers")
			case "$kernel" in
				linux) nvidia_modules+=(nvidia-open) ;;
				linux-lts) nvidia_modules+=(nvidia-open-lts) ;;
				*) nvidia_needs_dkms=true ;;
			esac
		fi
	done
	if [ "$nvidia_needs_dkms" == true ]; then
		driver_system+=(nvidia-open-dkms)
	else
		driver_system+=("${nvidia_modules[@]}")
	fi

	ui_desktop=(
		hyprland
		hyprpicker
		hyprpolkitagent
		hyprsysteminfo
		grim
		slurp
		gtk3
		nwg-look
		adw-gtk-theme
		qt5-wayland
		qt6-wayland
		noto-fonts
		ttf-jetbrains-mono-nerd
		maplemono-nf-unhinted
		ttf-hack-nerd
		noctalia-git
	)

	terminal_dev=(
		ghostty
		tmux
		zsh
		neovim
		python-pynvim
		git
		docker
		docker-compose
		docker-buildx
		lazydocker
		virtualbox
		virtualbox-host-dkms
		openvpn
		dbeaver
		postman-bin
		bruno-bin
		tree
		btop
		sshs
		bluetui
		pandoc-cli
		texlive
		luarocks
		tldr
		direnv
		mise
		ansible-lint
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
		thunderbird-i18n-pl
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

	load_brew_installed

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
		docker-desktop \
		ghostty \
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
		postgresql@17 \
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
		mise \
		lazydocker

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
