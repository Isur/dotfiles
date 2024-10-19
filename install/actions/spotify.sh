arch_spotify () {
	yay -S spotify-launcher --noconfirm
}

debian_spotify () { }

macos_spotify () { }

install_spotify() {
	nice_echo "Installing spotify"

	if [[ "$system" == "Arch Based" ]]; then
		arch_spotify
	elif [[ "$system" == "Debian Based" ]]; then
		debian_spotify
	elif [[ "$system" == "Darwin" ]]; then
		macos_spotify
	fi
}
