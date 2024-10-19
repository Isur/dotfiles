arch_neovim () {
	yay -S neovim --noconfirm
	create_symlink "nvim config" "nvim" ".config/nvim"
}

debian_neovim () {
	if ! command -v nvim &> /dev/null
	then
		nice_echo "Installing neovim!"
		sudo apt install xclip wl-clipboard luarocks -y
		curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
		chmod u+x nvim.appimage
		sudo mv nvim.appimage $HOME/apps/nvim
		create_symlink "nvim config" "nvim" ".config/nvim"
	else
		nice_echo "neovim is installed!"
	fi
}

macos_neovim () {
	brew install neovim
	create_symlink "nvim config" "nvim" ".config/nvim"
}

install_neovim () {
	nice_echo "Installing neovim!"
	if [[ "$system" == "Arch Based" ]]; then
		arch_neovim
	elif [[ "$system" == "Debian Based" ]]; then
		debian_neovim
	elif [[ "$system" == "Darwin" ]]; then
		macos_neovim
	fi	
}
