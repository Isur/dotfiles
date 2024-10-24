arch_gaming () {
	# Order is important here wine - steam - lutris
	yay -S wine --noconfirm
	yay -S steam --noconfirm
	yay -S lutris --noconfirm

	yay -S nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader --noconfirm
	yay -S gamemode lib32-gamemode --noconfirm

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
