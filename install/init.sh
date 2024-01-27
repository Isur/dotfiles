#!/bin/bash

source ./args.sh
source ./common.sh

nice_echo "Dotfiles installer"


nice_echo "System: $system" "Server: $server" "All: $all"

source ./setup.sh


source ./actions/dbeaver.sh
source ./actions/directories.sh
source ./actions/docker.sh
source ./actions/fonts.sh
source ./actions/git.sh
source ./actions/insomnia.sh
source ./actions/kitty.sh
source ./actions/alacritty.sh
source ./actions/neovim.sh
source ./actions/node.sh
source ./actions/ssh.sh
source ./actions/terminal_tools.sh
source ./actions/tmux.sh
source ./actions/zsh.sh
source ./actions/python.sh
source ./actions/repos.sh

if [ "$server" = "yes" ]; then
	mkdir -p $HOME/.local/bin
	sudo apt update -y
	sudo apt install build-essential curl libfuse2 snapd -y

	ask_action "Install terminal tools" install_terminal_tools
	ask_action "Install zsh" install_zsh
	ask_action "Install neovim" install_neovim
	ask_action "Install docker" install_docker
else
	system_setup
	ask_action "Create directory structure" create_directory_structure

	ask_action "Install terminal tools" install_terminal_tools
	ask_action "Install zsh" install_zsh
	ask_action "Install tmux" install_tmux
	ask_action "Install neovim" install_neovim
	ask_action "Install node" install_node
	ask_action "Install pyenv" install_pyenv

	ask_action "Setup ssh" setup_ssh

	ask_action "Install kitty" install_kitty
	ask_action "Install alacritty" install_alacritty
	ask_action "Install fonts" install_fonts
	ask_action "Install LazyGit with Delta" setup_git
	ask_action "Install dbeaver" install_dbeaver
	ask_action "Install docker" install_docker
	ask_action "Install insomnia" install_insomnia

	ask_action "Setup work repos" work_repos
	ask_action "Setup private repos" private_repos
fi


