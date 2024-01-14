#!/bin/bash

system=""
server="no"

install_question () {
	echo "Do you want to install $1? (y/n)"
	read answer
	if [ "$answer" != "${answer#[Yy]}" ] ;then
		$2
	else
		echo Skipping $1 installation!
	fi
}

create_symlink () {
	from="$HOME/dotfiles/$2"
	to="$HOME/$3"

	if [ ! -e $to ]; then
		echo Creating simlink for $1!
		ln -s $from $to
	else
		echo $1 already exists!
	fi
}

check_system () {
	if [ "$(uname)" == "Darwin" ]; then
		echo "MacOS detected!"
		system="Darwin"
		setup_darwin
	elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
		echo "Linux detected!"
		system="Linux"
		# check if it's arch based
		if [ -f /etc/arch-release ]; then
			echo "Arch based distro detected!"
			setup_arch
		elif [ -f /etc/debian_version ]; then
			echo "Debian based distro detected!"
			setup_debian
		fi
	elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
		echo "Windows detected!"
		system="Windows"
	fi
}

setup_debian() {
	mkdir -p $HOME/apps
	mkdir -p $HOME/.config

	install_with_apt () {
		echo "Installing $1!"
		sudo apt install $1 -y
	}

	install_utils () {
		echo "Installing utils!"
		install_with_apt fzf
		install_with_apt ripgrep
		install_with_apt fd-find
		install_with_snap btop
		mkdir -p $HOME/.config/btop/themes
		create_symlink "btop theme" "themes/btop/catppuccin.theme" ".config/btop/themes/catppuccin.theme"
	}

	install_ideavim_config () {
		echo "Installing ideavim config!"
		create_symlink "ideavim config" "ideavimrc" ".ideavimrc"
	}

	install_tmux () {
		install_with_apt tmux
		create_symlink "tmux config" "tmux.conf" ".tmux.conf"
	}

	install_neovim () {
		curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
		chmod u+x nvim.appimage
		sudo mv nvim.appimage $HOME/apps/nvim
		create_symlink "nvim config" "nvim" ".config/nvim"
	}

	install_kitty () {
		install_with_apt kitty
		create_symlink "kitty config" "kitty" ".config/kitty"
	}

	install_zsh () {
		install_with_apt zsh
		echo "Installing oh-my-zsh!"
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
		git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
		mv $HOME/.zshrc $HOME/.zshrc.old

		if [ "$server" == "yes" ]; then
			create_symlink "zsh config" "zshrc-server" ".zshrc"
		else
			create_symlink "zsh config" "zshrc-local" ".zshrc"
		fi
	}

	echo "Are you installing this on server? (y/n)"
	read serverQuestion
	if [ "$serverQuestion" != "${serverQuestion#[Yy]}" ] ;then
		server="yes"
		sudo apt update
		install_utils
		install_neovim
		install_zsh
	else
		server="no"
		sudo apt update -y && sudo apt upgrade -y
		install_question "utils" install_utils
		install_question "tmux" install_tmux
		install_question "nvim" install_neovim
		install_question "kitty" install_kitty
		install_question "zsh" install_zsh
		install_question "ideavim config" install_ideavim_config
	fi
}

setup_arch () {
	install_with_yay () {
		echo "Installing $1!"
		yay -S $1 --noconfirm --sudoloop
	}

	install_utils () {
		echo "Installing utils!"
		install_with_yay fzf
		install_with_yay ripgrep
		install_with_yay fd
		install_with_yay btop

		create_symlink "btop theme" "themes/btop/catppuccin.theme" ".config/btop/themes/catppuccin.theme"
	}

	install_ideavim_config () {
		echo "Installing ideavim config!"
		create_symlink "ideavim config" "ideavimrc" ".ideavimrc"
	}

	install_tmux () {
		install_with_yay tmux
		create_symlink "tmux config" "tmux.conf" ".tmux.conf"
	}

	install_neovim () {
		install_with_yay neovim
		create_symlink "nvim config" "nvim" ".config/nvim"
	}

	install_kitty () {
		install_with_yay kitty
		create_symlink "kitty config" "kitty" ".config/kitty"
	}

	install_zsh () {
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
