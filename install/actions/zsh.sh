arch_zsh () {
	yay -S zsh --noconfirm
}

debian_zsh () {
	sudo apt install zsh -y
}

macos_zsh () {
	brew install zsh
}

change_shell () {
	nice_echo "Changing shell!"
	sudo chsh -s $(which zsh) $(whoami)
}

install_zsh () {
	if [[ "$system" == "Arch Based" ]]; then
		arch_zsh
	elif [[ "$system" == "Debian Based" ]]; then
		debian_zsh
	elif [[ "$system" == "Darwin" ]]; then
		macos_zsh
	fi
	rm -rf $HOME/.oh-my-zsh/
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	mkdir -p ${ZSH_CUSTOM:=$HOME/.oh-my-zsh/custom}/plugins

	create_symlink "zsh config" "zshrc-local" ".zshrc"

	change_shell
}
