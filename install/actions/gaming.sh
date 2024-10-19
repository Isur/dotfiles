arch_gaming () {
	yay -S steam lutris wine --noconfirm
}

debian_gaming () {
	echo "Not implemented installing gaming tools for debian"
}

macos_gaming () {
	echo "Gaming on mac? Huh?"
}

install_gaming() {
	nice_echo "Installing gaming tools"

	if [[ "$system" == "Arch Based" ]]; then
		arch_gaming
	elif [[ "$system" == "Debian Based" ]]; then
		debian_gaming
	elif [[ "$system" == "Darwin" ]]; then
		macos_gaming
	fi
}
