#!/bin/bash

install_question () {
	# usage: install_question "name" "function"
	echo "Do you want to install $1? (y/n)"
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then
		$2
	else
		echo Skipping $1 installation!
	fi
}

create_symlink () {
	# usage: create_symlink "name" "path/to/file" "path/to/symlink"
	if [ ! -f "$HOME/$3" ]; then
		echo Creating simlink for $1!
		ln -s ~/dotfiles/$2 ~/$3
	else
		echo $1 already exists!
	fi
}

check_system () {
	if [ "$(uname)" == "Darwin" ]; then
		echo "MacOS detected!"
		system="Darwin"
		setip_darwin
	elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
		echo "Linux detected!"
		system="Linux"
	elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
		echo "Windows detected!"
		system="Windows"
	fi
}

install_with_yay () {
	# usage: install_with_yay "package_name"
	echo "Installing $1!"
	yay -S $1 --noconfirm --sudoloop
}

setup_linux () {
	install_utils () {
		echo "Installing utils!"
		echo "Installing fzf!"
		install_with_yay fzf
		echo "Installing ripgrep!"
		install_with_yay ripgrep
		echo "Installing fd!"
		install_with_yay fd
		echo "Installing btop!"
		install_with_yay btop

		create_symlink "btop theme" "themes/btop/catppuccin.theme" ".config/btop/themes/catppuccin.theme"
	}

	install_ideavim_config () {
		echo "Installing ideavim config!"
		create_symlink "ideavim config" "ideavimrc" ".ideavimrc"
	}

	install_tmux () {
		echo "Installing tmux!"
		install_with_yay tmux
		create_symlink "tmux config" "tmux.conf" ".tmux.conf"
	}

	install_neovim () {
		echo "Installing neovim!"
		install_with_yay neovim
		create_symlink "nvim config" "nvim" ".config/nvim"
	}

	install_kitty () {
		echo "Installing kitty!"
		install_with_yay kitty
		create_symlink "kitty config" "kitty" ".config/kitty"
	}

	install_zsh () {
		echo "Installing zsh!"
		install_with_yay zsh
		echo "Installing oh-my-zsh!"
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
		git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
	}

	install_question "utils" install_utils
	install_question "tmux" install_tmux
	install_question "nvim" install_neovim
	install_question "kitty" install_kitty
	install_question "zsh" install_zsh
	install_question "ideavim config" install_ideavim_config
}

setup_darwin() {
	echo "Setting up MacOS!"
	echo "Installing homebrew!"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

	install_utils () {
		echo "Installing utils!"
		echo "Installing fzf!"
		brew install fzf
		echo "Installing ripgrep!"
		brew install ripgrep
		echo "Installing fd!"
		brew install fd
		echo "Installing btop!"
		brew install btop

		create_symlink "btop theme" "themes/btop/catppuccin.theme" ".config/btop/themes/catppuccin.theme"
	}
	
	install_ideavim_config () {
		echo "Installing ideavim config!"
		create_symlink "ideavim config" "ideavimrc" ".ideavimrc"
	}

	install_tmux () {
		echo "Installing tmux!"
		brew install tmux
		create_symlink "tmux config" "tmux.conf" ".tmux.conf"
	}

	install_neovim () {
		echo "Installing neovim!"
		brew install neovim
		create_symlink "nvim config" "nvim" ".config/nvim"
	}

	install_kitty () {
		echo "Installing kitty!"
		brew install kitty
		create_symlink "kitty config" "kitty" ".config/kitty"
	}

	install_zsh () {
		echo "Installing zsh!"
		brew install zsh
		echo "Installing oh-my-zsh!"
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
		git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
	}


	install_question "utils" install_utils
	install_question "tmux" install_tmux
	install_question "nvim" install_neovim
	install_question "kitty" install_kitty
	install_question "zsh" install_zsh
	install_question "ideavim config" install_ideavim_config
}
check_system
