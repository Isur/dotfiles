arch_brave () {
	yay -S brave-bin --noconfirm
}

debian_brave () {
	sudo apt install curl
	sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
	sudo apt update
	sudo apt install brave-browser
}

macos_brave () {
	brew install --cask brave-browser
}

install_brave () {
	nice_echo "Installing brave"

	if [[ "$system" == "Arch Based" ]]; then
		arch_brave
	elif [[ "$system" == "Debian Based" ]]; then
		debian_brave
	elif [[ "$system" == "Darwin" ]]; then
		macos_brave
	fi	
}
