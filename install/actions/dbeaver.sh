arch_dbeaver () {
	yay -S dbeaver --noconfirm
}

debian_dbeaver () {
	sudo snap install dbeaver-ce
}

macos_dbeaver () {
	brew install --cask dbeaver-community
}

install_dbeaver () {
	nice_echo "Installing DBeaver"

	if [[ "$system" == "Arch Based" ]]; then
		arch_dbeaver
	elif [[ "$system" == "Debian Based" ]]; then
		debian_dbeaver
	elif [[ "$system" == "Darwin" ]]; then
		macos_dbeaver
	fi	
}
