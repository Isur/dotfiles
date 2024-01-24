source ./args.sh
source ./common.sh

nice_echo "Dotfiles installer"


nice_echo "System: $system" "Server: $server" "All: $all"

source ./installers.sh
source ./setup.sh

system_setup

source ./actions/dbeaver.sh
source ./actions/directories.sh
source ./actions/docker.sh
source ./actions/git.sh
source ./actions/insomnia.sh
source ./actions/kitty.sh
source ./actions/neovim.sh
source ./actions/node.sh
source ./actions/ssh.sh
source ./actions/terminal_tools.sh
source ./actions/tmux.sh
source ./actions/zsh.sh

ask_action "Create directory structure" create_directory_structure

ask_action "Install terminal tools" terminal_tools
ask_action "Install zsh" install_zsh
ask_action "Install tmux" install_tmux
ask_action "Install neovim" install_neovim
ask_action "Install node" install_node

ask_action "Setup ssh" setup_ssh

ask_action "Install kitty" install_kitty
ask_action "Install LazyGit with Delta" setup_git
ask_action "Install dbeaver" install_dbeaver
ask_action "Install docker" install_docker
ask_action "Install insomnia" install_insomnia




