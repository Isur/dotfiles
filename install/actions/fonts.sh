arch_fonts () {
	yay -S ttf-jetbrains-mono-nerd --noconfirm
}

debian_fonts () {
	mkdir -p ~/.local/share/fonts
	fonturl=https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
	wget $fonturl -O fonts.zip
	unzip fonts.zip -d ~/.local/share/fonts
	rm fonts.zip
	fc-cache -fv
}

macos_fonts () {
	brew tap homebrew/cask-fonts
	brew install font-jetbrains-mono-nerd-font
}

install_fonts () {
	nice_echo "Fonts"
	if [[ "$system" == "Arch Based" ]]; then
		arch_fonts
	elif [[ "$system" == "Debian Based" ]]; then
		debian_fonts
	elif [[ "$system" == "Darwin" ]]; then
		macos_fonts
	fi	
}
