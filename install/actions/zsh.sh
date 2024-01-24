arch_zsh () {
	install_with_yay zsh
}

debian_zsh () {
	install_with_apt zsh
}

macos_zsh () {
	brew install zsh
}

change_shell () {
	if [ "$server" == "yes" ]; then
		nice_echo "Skipping shell change!"
	else
		nice_echo "Changing shell!"
		sudo chsh -s $(which zsh) $(whoami)
	fi
}

install_zsh () {
	if ! command -v zsh &> /dev/null
	then
		if [[ "$system" == "Arch Based" ]]; then
			arch_zsh
		elif [[ "$system" == "Debian Based" ]]; then
			debian_zsh
		elif [[ "$system" == "MacOS" ]]; then
			macos_zsh
		fi	
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
		git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
		git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

		create_symlink "zsh config" "zshrc-local" ".zshrc"
		change_shell
	else
		nice_echo "zsh is installed!"
	fi
}
