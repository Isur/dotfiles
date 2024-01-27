arch_alacritty () {
	yay -S alacritty --noconfirm
}

debian_alacritty () {
	sudo add-apt-repository ppa:aslatter/ppa -y
	sudo apt install alacritty -y
}

macos_alacritty () {
	brew install --cask alacritty
}

install_alacritty () {
	nice_echo "alacritty"
	if [[ "$system" == "Arch Based" ]]; then
		arch_alacritty
	elif [[ "$system" == "Debian Based" ]]; then
		debian_alacritty
	elif [[ "$system" == "Darwin" ]]; then
		macos_alacritty
	fi	
	create_symlink "alacritty config" "alacritty.toml" ".alacritty.toml"
}
