#!/bin/bash

system=""
server="no"
all="no"

while [[ $# -gt 0 ]]; do
	case "$1" in
		-s|--server)
			server="yes"
			shift;;
		-a|--all)
			all="yes"
			shift;;
		-h|--help)
			echo "Usage: $0 [-s|--server] [-a|--all]"
			exit 0;;
		*)
			echo "Usage: $0 [-s|--server] [-a|--all]"
			exit 1;;
	esac
done

install_question () {
	if [ "$all" == "yes" ]; then
		$2
	else
		nice_echo "Do you want to install $1? (y/n)"
		read answer
		if [ "$answer" != "${answer#[Yy]}" ] ;then
			$2
		else
			nice_echo "Skipping $1 installation!"
		fi
	fi
}

create_symlink () {
	from="$HOME/dotfiles/$2"
	to="$HOME/$3"

	if [ ! -e "$to" ]; then
		nice_echo "Creating simlink for $1!"
		ln -s "$from" "$to"
	else
		old="$to".old
		if [ -e "$old" ]; then
			nice_echo "Old $1 config already exists!"
			return 0
		else
			nice_echo "Moving old $1 config to $old!"
			mv "$to" "$old"
			nice_echo "Creating simlink for $1!"
			ln -s "$from" "$to"
		fi
	fi
}

create_directory_structure () {
	mkdir -p $HOME/apps
	mkdir -p $HOME/.config
	mkdir -p $HOME/.local/bin
	mkdir -p $HOME/Developer
	mkdir -p $HOME/Developer/Clients
	mkdir -p $HOME/Developer/Personal
	mkdir -p $HOME/Developer/PoC
	mkdir -p $HOME/Developer/Global

	cp ./docker-compose.yml $HOME/Developer/Global/docker-compose.yml
}

nice_echo () {
	echo "------------------------------------------------------------"
	echo ""
	echo "$1"
	echo ""
	echo "------------------------------------------------------------"
}

check_system () {
	if [ "$(uname)" == "Darwin" ]; then
		nice_echo "MacOS detected!"
		system="Darwin"
		setup_darwin
	elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
		nice_echo "Linux detected!"
		system="Linux"
		if [ -f /etc/arch-release ]; then
			nice_echo "Arch based distro detected!"
			setup_arch
		elif [ -f /etc/debian_version ]; then
			nice_echo "Debian based distro detected!"
			setup_debian
		fi
	fi
}

install_node () {
	if ! command -v nvm &> /dev/null
	then
		nice_echo "Installing nvm!"
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
		source ~/.zshrc
	else
		nice_echo "nvm is installed!"
	fi

	nvm install --lts
	npm install -g pnpm
}

change_shell () {
	if [ "$server" == "yes" ]; then
		nice_echo "Skipping shell change!"
	else
		nice_echo "Changing shell!"
		sudo chsh -s $(which zsh) $(whoami)
	fi
}

setup_debian() {
	sudo apt update -y
	sudo apt install build-essential curl libfuse2 snapd python3-pip python3-venv -y
	sudo pip install --upgrade pip
	create_directory_structure

	install_with_apt () {
		nice_echo "Installing $1!"
		sudo apt install $1 -y
	}

	install_with_snap () {
		nice_echo "Installing $1!"
		sudo snap install $1
	}

	config_git () {
		# check if lazygit is installed
		if ! command -v lazygit &> /dev/null
		then
			nice_echo "Installing lazygit!"
			LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
			curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
			tar xf lazygit.tar.gz lazygit
			sudo install lazygit $HOME/apps
			rm lazygit.tar.gz
			rm -rf lazygit

			mkdir -p $HOME/.config/lazygit
			create_symlink "lazygit" "git-configs/lazygit.yml" ".config/lazygit/config.yml"
		else
			nice_echo "lazygit is installed!"
		fi

		# check if delta is installed
		if ! command -v delta &> /dev/null
		then
			nice_echo "Installing delta!"

			DELTA_VERSION=0.16.5
			curl -L https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb -o delta.deb
			sudo dpkg -i delta.deb
			rm delta.deb

			create_symlink "gitconfig" "git-configs/gitconfig" ".gitconfig"
		else 
			nice_echo "delta is installed!"
		fi
	}

	install_utils () {
		nice_echo "Installing utils!"
		install_with_apt fzf
		install_with_apt ripgrep
		install_with_apt fd-find
		install_with_snap btop
		mkdir -p $HOME/.config/btop/themes
		ln -s $(which fdfind) $HOME/.local/bin/fd
		create_symlink "btop theme" "themes/btop/catppuccin.theme" ".config/btop/themes/catppuccin.theme"

	}

	install_tmux () {
		install_with_apt tmux
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
		create_symlink "tmux config" "tmux.conf" ".tmux.conf"
	}

	install_neovim () {
		if ! command -v nvim &> /dev/null
		then
			nice_echo "Installing neovim!"
			install_with_apt xclip wl-clipboard -y
			curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
			chmod u+x nvim.appimage
			sudo mv nvim.appimage $HOME/apps/nvim
			create_symlink "nvim config" "nvim" ".config/nvim"
		else
			nice_echo "neovim is installed!"
		fi
	}

	install_kitty () {
		install_with_apt kitty
		nice_echo "Installing fonts"
		mkdir -p ~/.local/share/fonts
		fonturl=https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
		wget $fonturl -O fonts.zip
		unzip fonts.zip -d ~/.local/share/fonts
		rm fonts.zip
		fc-cache -fv
		create_symlink "kitty config" "kitty" ".config/kitty"
	}

	install_zsh () {
		if ! command -v zsh &> /dev/null
		then
			install_with_apt zsh
			nice_echo "Installing oh-my-zsh!"
			sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
			git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
			git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
			git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

			if [ "$server" == "yes" ]; then
				create_symlink "zsh config" "zshrc-server" ".zshrc"
			else
				create_symlink "zsh config" "zshrc-local" ".zshrc"
				change_shell
			fi
		else
			nice_echo "zsh is installed!"
		fi
	}

	install_docker () {
		sudo apt-get update
		sudo apt-get install ca-certificates curl gnupg -y
		sudo install -m 0755 -d /etc/apt/keyrings
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
		sudo chmod a+r /etc/apt/keyrings/docker.gpg
		echo \
		  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
		  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
		  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
		sudo apt-get update
		sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

		sudo getent group docker || sudo groupadd docker
		sudo usermod -aG docker $USER
		sudo systemctl enable docker
	}

	if [ "$server" == "yes" ]; then
		install_utils
		install_neovim
		install_zsh
		install_question "docker" install_docker
	else
		install_question "utils" install_utils
		install_question "tmux" install_tmux
		install_question "nvim" install_neovim
		install_question "kitty" install_kitty
		install_question "zsh" install_zsh
		install_question "git config" config_git
		install_question "node" install_node
		install_question "docker" install_docker
	fi
}

setup_arch () {
	create_directory_structure

	install_yay () {
		nice_echo "Installing yay!"
		sudo pacman -S --needed git base-devel
		rm -rf yay
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
		nice_echo "yay is installed!"
	fi

	yay --noconfirm --sudoloop

	install_with_yay () {
		nice_echo "Installing $1!"
		yay -S $1 --noconfirm --sudoloop
	}

	config_git () {
		install_with_yay git-delta
		install_with_yay lazygit

		mkdir -p $HOME/.config/lazygit
		create_symlink "gitconfig" "git-configs/gitconfig" ".gitconfig"
		create_symlink "lazygit" "git-configs/lazygit.yml" ".config/lazygit/config.yml"
	}

	install_utils () {
		nice_echo "Installing utils!"
		install_with_yay fzf
		install_with_yay ripgrep
		install_with_yay fd
		install_with_yay btop
		create_symlink "btop theme" "themes/btop/catppuccin.theme" ".config/btop/themes/catppuccin.theme"
	}

	install_tmux () {
		install_with_yay tmux
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
		create_symlink "tmux config" "tmux.conf" ".tmux.conf"
	}

	install_neovim () {
		install_with_yay neovim
		create_symlink "nvim config" "nvim" ".config/nvim"
	}

	install_kitty () {
		install_with_yay kitty
		install_with_yay ttf-jetbrains-mono-nerd
		create_symlink "kitty config" "kitty" ".config/kitty"
	}

	install_zsh () {
		if ! command -v zsh &> /dev/null
		then
			install_with_yay zsh
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

	install_docker() {
		install_with_yay docker
		install_with_yay docker-compose
		install_with_yay docker-buildx
		sudo getent group docker || sudo groupadd docker
		sudo usermod -aG docker $USER
		sudo systemctl enable docker
	}


	install_question "utils" install_utils
	install_question "tmux" install_tmux
	install_question "nvim" install_neovim
	install_question "kitty" install_kitty
	install_question "zsh" install_zsh
	install_question "config git" config_git
	install_question "node" install_node
	install_question "docker" install_docker
}

setup_darwin() {
	nice_echo "Setting up MacOS!"
	create_directory_structure

	which -s brew
	if [[ $? != 0 ]] ; then
		nice_echo "Installing homebrew!"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	else
		nice_echo "Update brew"
		brew update
	fi

	config_git () {
		nice_echo "Installing delta"
		brew install git-delta
		nice_echo "Installing lazygit"
		brew install lazygit

		mkdir -p $HOME/.config/lazygit

		create_symlink "gitconfig" "git-configs/gitconfig" ".gitconfig"
		create_symlink "lazygit" "git-configs/lazygit.yml" "Library/Application Support/lazygit/config.yml"
	}

	install_utils () {
		nice_echo "Installing utils!"
		nice_echo "Installing fzf!"
		brew install fzf
		nice_echo "Installing ripgrep!"
		brew install ripgrep
		nice_echo "Installing fd!"
		brew install fd
		nice_echo "Installing btop!"
		brew install btop
		nice_echo "Installing gnu-sed"
		brew install gnu-sed

		create_symlink "btop theme" "themes/btop/catppuccin.theme" ".config/btop/themes/catppuccin.theme"
	}

	install_tmux () {
		nice_echo "Installing tmux!"
		brew install tmux
		create_symlink "tmux config" "tmux.conf" ".tmux.conf"
	}

	install_neovim () {
		nice_echo "Installing neovim!"
		brew install neovim
		create_symlink "nvim config" "nvim" ".config/nvim"
	}

	install_kitty () {
		nice_echo "Installing fonts"
		brew tap homebrew/cask-fonts
		brew install font-jetbrains-mono-nerd-font
		nice_echo "Installing kitty!"
		brew install kitty
		create_symlink "kitty config" "kitty" ".config/kitty"
	}

	install_zsh () {
		if ! command -v zsh &> /dev/null
		then
			nice_echo "Installing zsh!"
			brew install zsh
			nice_echo "Installing oh-my-zsh!"
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

	install_docker () {
		nice_echo "Installing docker!"
		brew install --cask docker
		sudo usermod -aG docker $USER
	}

	install_question "utils" install_utils
	install_question "tmux" install_tmux
	install_question "nvim" install_neovim
	install_question "kitty" install_kitty
	install_question "zsh" install_zsh
	install_question "config git" config_git
	install_question "node" install_node
	install_question "docker" install_docker
}
check_system
