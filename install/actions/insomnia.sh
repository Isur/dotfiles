arch_insomnia () {
	yay -S insomnia-bin --noconfirm
}

debian_insomnia () {
	sudo snap install insomnia
}

macos_insomnia () {
	brew install --cask insomnia
}

install_insomnia () {
	nice_echo "Installing insomnia"
	if [[ "$system" == "Arch Based" ]]; then
		arch_insomnia
	elif [[ "$system" == "Debian Based" ]]; then
		debian_insomnia
	elif [[ "$system" == "Darwin" ]]; then
		macos_insomnia
	fi	
}
