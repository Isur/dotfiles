arch_dbeaver () {
	install_with_yay dbeaver
}

debian_dbeaver () {
	install_with_snap dbeaver-ce
}

macos_dbeaver () {
	install_with_brew --cask dbeaver-community
}

install_dbeaver () {
	nice_echo "Installing DBeaver"

	if [[ "$system" == "Arch Based" ]]; then
		arch_dbeaver
	elif [[ "$system" == "Debian Based" ]]; then
		debian_dbeaver
	elif [[ "$system" == "MacOS" ]]; then
		macos_dbeaver
	fi	
}
