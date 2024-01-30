arch_tiling () {
	echo
}

debian_tiling () {
	echo
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
