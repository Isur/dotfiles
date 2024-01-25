arch_kitty () {
	yay -S ttf-jetbrains-mono-nerd --noconfirm
}

debian_kitty () {
	mkdir -p ~/.local/share/fonts
	fonturl=https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
	wget $fonturl -O fonts.zip
	unzip fonts.zip -d ~/.local/share/fonts
	rm fonts.zip
	fc-cache -fv
}

macos_kitty () {
	brew tap homebrew/cask-fonts
	brew install font-jetbrains-mono-nerd-font
}

install_kitty () {
	nice_echo "Fonts"
	if [[ "$system" == "Arch Based" ]]; then
		arch_kitty
	elif [[ "$system" == "Debian Based" ]]; then
		debian_kitty
	elif [[ "$system" == "MacOS" ]]; then
		macos_kitty
	fi	
}
