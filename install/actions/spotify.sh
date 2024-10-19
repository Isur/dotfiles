arch_spotify () {
	yay -S spotify-launcher --noconfirm
}

debian_spotify () {
	echo "Not implemented debian installation for spotify"
}

macos_spotify () {
	echo "Not implemented macos installation for spotify"
}

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
