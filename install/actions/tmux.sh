arch_tmux () {
	yay -S tmux --noconfirm
}

debian_tmux () {
	sudo apt install tmux -y
}

macos_tmux () {
	brew install tmux
}

install_tmux () {
	nice_echo "Installing tmux"

	if [[ "$system" == "Arch Based" ]]; then
		arch_tmux
	elif [[ "$system" == "Debian Based" ]]; then
		debian_tmux
	elif [[ "$system" == "Darwin" ]]; then
		macos_tmux
	fi	

	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	create_symlink "tmux config" "tmux.conf" ".tmux.conf"
}
