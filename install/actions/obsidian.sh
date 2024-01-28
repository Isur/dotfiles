arch_obsidian () {
	yay -S obsidian-bin --noconfirm
}

debian_obsidian () {
	sudo snap install obsidian --classic
}

macos_obsidian () {
	brew install --cask obsidian
}

install_obsidian () {
	nice_echo "Installing obsidian"

	if [[ "$system" == "Arch Based" ]]; then
		arch_obsidian
	elif [[ "$system" == "Debian Based" ]]; then
		debian_obsidian
	elif [[ "$system" == "Darwin" ]]; then
		macos_obsidian
	fi
}
