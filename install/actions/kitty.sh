arch_kitty () {
	install_with_yay kitty
	install_with_yay ttf-jetbrains-mono-nerd
}

debian_kitty () {
	install_with_apt kitty
	nice_echo "Installing fonts"
	mkdir -p ~/.local/share/fonts
	fonturl=https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
	wget $fonturl -O fonts.zip
	unzip fonts.zip -d ~/.local/share/fonts
	rm fonts.zip
	fc-cache -fv
}

macos_kitty () {
	nice_echo "Installing fonts"
	brew tap homebrew/cask-fonts
	brew install font-jetbrains-mono-nerd-font
	nice_echo "Installing kitty!"
	brew install kitty
}

install_kitty () {
	nice_echo "Installing kitty and fonts"
	if [[ "$system" == "Arch Based" ]]; then
		arch_kitty
	elif [[ "$system" == "Debian Based" ]]; then
		debian_kitty
	elif [[ "$system" == "MacOS" ]]; then
		macos_kitty
	fi	
	create_symlink "kitty config" "kitty" ".config/kitty"
}
