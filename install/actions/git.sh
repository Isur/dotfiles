arch_git () {
		install_with_yay git-delta
		install_with_yay lazygit

		mkdir -p $HOME/.config/lazygit
		create_symlink "gitconfig" "git-configs/gitconfig" ".gitconfig"
		create_symlink "lazygit" "git-configs/lazygit.yml" ".config/lazygit/config.yml"
}

debian_git () {
		if ! command -v lazygit &> /dev/null
		then
			LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
			curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
			tar xf lazygit.tar.gz lazygit
			sudo install lazygit $HOME/apps
			rm lazygit.tar.gz
			rm -rf lazygit

			mkdir -p $HOME/.config/lazygit
			create_symlink "lazygit" "git-configs/lazygit.yml" ".config/lazygit/config.yml"
		fi

		# check if delta is installed
		if ! command -v delta &> /dev/null
		then
			DELTA_VERSION=0.16.5
			curl -L https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb -o delta.deb
			sudo dpkg -i delta.deb
			rm delta.deb

			create_symlink "gitconfig" "git-configs/gitconfig" ".gitconfig"
		fi
}

macos_git () {
		brew install git-delta
		brew install lazygit

		mkdir -p $HOME/.config/lazygit

		create_symlink "gitconfig" "git-configs/gitconfig" ".gitconfig"
		create_symlink "lazygit" "git-configs/lazygit.yml" "Library/Application Support/lazygit/config.yml"
}

setup_git () {
	nice_echo "Setting up git - lazygit and delta"

	if [[ "$system" == "Arch Based" ]]; then
		arch_git
	elif [[ "$system" == "Debian Based" ]]; then
		debian_git
	elif [[ "$system" == "MacOS" ]]; then
		macos_git
	fi	
}
