arch_kitty () {
	yay -S kitty --noconfirm
}

debian_kitty () {
	sudo apt install kitty -y
}

macos_kitty () {
	brew install kitty
}

install_kitty () {
	nice_echo "Kitty"
	if [[ "$system" == "Arch Based" ]]; then
		arch_kitty
	elif [[ "$system" == "Debian Based" ]]; then
		debian_kitty
	elif [[ "$system" == "MacOS" ]]; then
		macos_kitty
	fi	
	create_symlink "kitty config" "kitty" ".config/kitty"
}
