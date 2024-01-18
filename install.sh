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

	if [ ! -e "$to" ]; then
		echo Creating simlink for $1!
		ln -s "$from" "$to"
	else
		old="$to".old
		if [ -e "$old" ]; then
			echo "Old $1 config already exists!"
			return 0
		else
			echo "Moving old $1 config to $old!"
			mv "$to" "$old"
			echo Creating simlink for $1!
			ln -s "$from" "$to"
		fi
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
		if [ -f /etc/arch-release ]; then
			echo "Arch based distro detected!"
			setup_arch
		elif [ -f /etc/debian_version ]; then
			echo "Debian based distro detected!"
			setup_debian
		fi
	fi
}

install_node () {
	if ! command -v nvm &> /dev/null
	then
		echo "Installing nvm!"
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
		source ~/.zshrc
	else
		echo "nvm is installed!"
	fi

	nvm install --lts
	npm install -g pnpm
}

setup_debian() {
	sudo apt update -y
	sudo apt install build-essential curl libfuse2 snapd -y
	mkdir -p $HOME/apps
	mkdir -p $HOME/.config


	install_with_apt () {
		echo "Installing $1!"
		sudo apt install $1 -y
	}

	install_with_snap () {
		echo "Installing $1!"
		sudo snap install $1
	}

	config_git () {
		LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
		curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
		tar xf lazygit.tar.gz lazygit
		sudo install lazygit $HOME/apps
		rm lazygit.tar.gz
		rm -rf lazygit
		install_with_apt git-delta

		create_symlink "gitconfig" "git-configs/gitconfig" ".gitconfig"
		create_symlink "lazygit" "git-configs/lazygit.yml" ".config/lazygit/config.yml"
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
		git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

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
		install_utils
		install_tmux
		install_neovim
		install_zsh
	else
		server="no"
		sudo apt upgrade -y
		install_question "utils" install_utils
		install_question "tmux" install_tmux
		install_question "nvim" install_neovim
		install_question "kitty" install_kitty
		install_question "zsh" install_zsh
		install_question "ideavim config" install_ideavim_config
		install_question "git config" config_git
		install_question "node" install_node
	fi
}

setup_arch () {
	mkdir -p $HOME/apps
	mkdir -p $HOME/.config

	install_yay () {
		echo "Installing yay!"
		git clone https://aur.archlinux.org/yay.git
		cd yay
		makepkg -si
		cd ..
		rm -rf yay
	}

	if ! command -v yay &> /dev/null
	then
		install_yay
	else
		echo "yay is installed!"
	fi

	install_with_yay () {
		echo "Installing $1!"
		yay -S $1 --noconfirm --sudoloop
	}

	config_git () {
		install_with_yay git-delta
		install_with_yay lazygit

		create_symlink "gitconfig" "git-configs/gitconfig" ".gitconfig"
		create_symlink "lazygit" "git-configs/lazygit.yml" ".config/lazygit/config.yml"
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
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
		git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
		git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

		create_symlink "zsh config" "zshrc-local" ".zshrc"
	}


	install_question "utils" install_utils
	install_question "tmux" install_tmux
	install_question "nvim" install_neovim
	install_question "kitty" install_kitty
	install_question "zsh" install_zsh
	install_question "ideavim config" install_ideavim_config
	install_question "config git" config_git
	install_question "node" install_node
}

setup_darwin() {
	echo "Setting up MacOS!"

	which -s brew
	if [[ $? != 0 ]] ; then
		echo "Installing homebrew!"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	else
		echo "Update brew"
		brew update
	fi

	config_git () {
		echo "Installing delta"
		brew install git-delta
		echo "Installing lazygit"
		brew install lazygit

		create_symlink "gitconfig" "git-configs/gitconfig" ".gitconfig"
		create_symlink "lazygit" "git-configs/lazygit.yml" "Library/Application Support/lazygit/config.yml"
	}

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
		echo "Installing gnu-sed"
		brew install gnu-sed

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
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
		git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
		git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

		create_symlink "zsh config" "zshrc-local" ".zshrc"
	}


	install_question "utils" install_utils
	install_question "tmux" install_tmux
	install_question "nvim" install_neovim
	install_question "kitty" install_kitty
	install_question "zsh" install_zsh
	install_question "ideavim config" install_ideavim_config
	install_question "config git" config_git
	install_question "node" install_node
}
check_system
