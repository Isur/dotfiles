arch_tmux () {
	install_with_yay tmux
}

debian_tmux () {
	install_with_apt tmux
}

macos_tmux () {
	install_with_brew tmux
}

install_tmux () {
	nice_echo "Installing tmux"

	if [[ "$system" == "Arch Based" ]]; then
		arch_tmux
	elif [[ "$system" == "Debian Based" ]]; then
		debian_tmux
	elif [[ "$system" == "MacOS" ]]; then
		macos_tmux
	fi	

	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	create_symlink "tmux config" "tmux.conf" ".tmux.conf"
}
