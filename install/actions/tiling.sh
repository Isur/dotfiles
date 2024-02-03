arch_tiling () {
	yay -S i3-wm rofi feh i3status dunst betterlockscreen-git --noconfirm

	create_symlink "i3" "i3" ".config/i3"
	create_symlink "i3status" "i3status" ".config/i3status"
	create_symlink "rofi" "rofi" ".config/rofi"
	create_symlink "dunst" "dunst" ".config/dunst"
	create_symlink "betterlockscreen" "betterlockscreen" ".config/betterlockscreen"
}

debian_tiling () {
	/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2023.02.18_all.deb keyring.deb SHA256:a511ac5f10cd811f8a4ca44d665f2fa1add7a9f09bef238cdfad8461f5239cc4
	sudo apt install ./keyring.deb
	echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
	sudo apt update
	sudo apt install i3 -y
	rm ./keyring.deb

	sudo apt install rofi -y
	sudo apt install feh -y
	sudo apt install betterlockscreen -y
	sudo apt install i3blocks -y
	sudo apt install fonts-font-awesome -y

	create_symlink "i3" "i3" ".config/i3"
	create_symlink "i3block" "i3blocks" ".config/i3blocks"
	create_symlink "rofi" "rofi" ".config/rofi"
	create_symlink "dunst" "dunst" ".config/dunst"
	create_symlink "betterlockscreen" "betterlockscreen" ".config/betterlockscreen"
}

macos_tiling () {
	brew install koekeishiya/formulae/yabai
	brew install koekeishiya/formulae/skhd
	brew tap FelixKratz/formulae
	brew install sketchybar
	brew install jq
	curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.16/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf
	curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.20/icon_map_fn.sh -o ~/.config/sketchybar/plugins/icon_map_fn.sh
	brew install --cask raycast

	create_symlink "yabai" "yabai" ".config/yabai"
	create_symlink "skhd" "skhd" ".config/skhd"
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
