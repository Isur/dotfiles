arch_terminal_tools () {
	yay -S fzf ripgrep fd btop --noconfirm
}

debian_terminal_tools () {
	sudo apt install fzf ripgrep fd-find -y
	sudo snap install btop
	ln -s $(which fdfind) $HOME/.local/bin/fd
}

macos_terminal_tools () {
	brew install fzf ripgrep fd btop gnu-sed jq
}

install_terminal_tools() {
	nice_echo "Installing fzf, ripgrep, fd, btop"
	mkdir -p $HOME/.config/btop/themes

	if [[ "$system" == "Arch Based" ]]; then
		arch_terminal_tools
	elif [[ "$system" == "Debian Based" ]]; then
		debian_terminal_tools
	elif [[ "$system" == "Darwin" ]]; then
		macos_terminal_tools
	fi	

	create_symlink "btop theme" "themes/btop/catppuccin.theme" ".config/btop/themes/catppuccin.theme"
}
