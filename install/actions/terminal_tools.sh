arch_terminal_tools () {
	install_with_yay fzf
	install_with_yay ripgrep
	install_with_yay fd
	install_with_yay btop
}

debian_terminal_tools () {
	install_with_apt fzf
	install_with_apt ripgrep
	install_with_apt fd-find
	install_with_snap btop
	ln -s $(which fdfind) $HOME/.local/bin/fd
}

macos_terminal_tools () {
	install_with_brew fzf
	install_with_brew ripgrep
	install_with_brew fd
	install_with_brew btop
	install_with_brew gnu-sed
}

install_terminal_tools() {
	nice_echo "Installing fzf, ripgrep, fd, btop"
	mkdir -p $HOME/.config/btop/themes

	if [[ "$system" == "Arch Based" ]]; then
		arch_terminal_tools
	elif [[ "$system" == "Debian Based" ]]; then
		debian_terminal_tools
	elif [[ "$system" == "MacOS" ]]; then
		macos_terminal_tools
	fi	

	create_symlink "btop theme" "themes/btop/catppuccin.theme" ".config/btop/themes/catppuccin.theme"
}
