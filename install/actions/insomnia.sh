arch_insomnia () {
	install_with_yay insomnia-bin
}

debian_insomnia () {
	install_with_snap insomnia
}

macos_insomnia () {
	install_with_brew_cask insomnia
}

install_insomnia () {
	nice_echo "Installing insomnia"
	if [[ "$system" == "Arch Based" ]]; then
		arch_insomnia
	elif [[ "$system" == "Debian Based" ]]; then
		debian_insomnia
	elif [[ "$system" == "MacOS" ]]; then
		macos_insomnia
	fi	
}
