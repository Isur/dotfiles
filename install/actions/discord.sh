arch_discord () {
	yay -S discord --noconfirm
}

debian_discord () {
	sudo snap install discord
}

macos_discord () {
	brew install --cask discord
}

install_discord () {
	nice_echo "Installing discord"

	if [[ "$system" == "Arch Based" ]]; then
		arch_discord
	elif [[ "$system" == "Debian Based" ]]; then
		debian_discord
	elif [[ "$system" == "Darwin" ]]; then
		macos_discord
	fi
}
