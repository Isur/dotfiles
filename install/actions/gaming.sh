arch_gaming () {
	yay -S gaming lutris wine --noconfirm
}

debian_gaming () { }

macos_gaming () { }

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
