arch_tiling () {
	yay -S i3-wm bazecor playerctl rofi feh i3blocks dunst betterlockscreen-git font-awesome-5 lm_sensors flameshot thunar thunderbird thunderbird-i18n sysstat gvfs polkit polkit-kde-agent --noconfirm

	mkdir -p $HOME/Pictures/Screenshots

	create_symlink "i3" "i3" ".config/i3"
	create_symlink "i3block" "i3blocks" ".config/i3blocks"
	create_symlink "rofi" "rofi" ".config/rofi"
	create_symlink "dunst" "dunst" ".config/dunst"
	create_symlink "betterlockscreen" "betterlockscreen" ".config/betterlockscreen"
}

debian_tiling () {
	/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2023.02.18_all.deb keyring.deb SHA256:a511ac5f10cd811f8a4ca44d665f2fa1add7a9f09bef238cdfad8461f5239cc4
	sudo apt install ./keyring.deb -y
	echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
	sudo apt update
	sudo apt install i3 -y
	rm ./keyring.deb

	sudo apt install rofi feh i3blocks imagemagick fonts-font-awesome lm-sensors flameshot thunar -y
	mkdir -p $HOME/Pictures/Screenshots

	# Dependencies to build i3lock-color
	sudo apt install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev -y

	# Build and install i3lock-color
	(cd /tmp && git clone https://github.com/Raymo111/i3lock-color.git && cd i3lock-color && ./install-i3lock-color.sh)
	wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | bash -s user

	create_symlink "i3" "i3" ".config/i3"
	create_symlink "i3block" "i3blocks" ".config/i3blocks"
	create_symlink "rofi" "rofi" ".config/rofi"
	create_symlink "dunst" "dunst" ".config/dunst"
	create_symlink "betterlockscreen" "betterlockscreen" ".config/betterlockscreen"
}

macos_tiling () {
	brew tap FelixKratz/formulae
	brew install sketchybar
	brew install jq
	curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.25/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf
	curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.25/icon_map.sh -o ~/.config/sketchybar/plugins/icon_map_fn.sh
	brew install --cask raycast
	brew install --cask nikitabobko/tap/aerospace
	brew install borders

	# remove the default empty config file create while installing aerospace
	rm $HOME/.aerospace.toml

	create_symlink "aerospace" "aerospace.toml" ".aerospace.toml"
	create_symlink "sketchybar" "sketchybar" ".config/sketchybar"
}

install_tiling () {
	nice_echo "Installing tiling"

	if [[ "$system" == "Arch Based" ]]; then
		arch_tiling
	elif [[ "$system" == "Debian Based" ]]; then
		debian_tiling
	elif [[ "$system" == "Darwin" ]]; then
		macos_tiling
	fi
}
