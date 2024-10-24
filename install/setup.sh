arch_setup () {
	install_yay () {
		nice_echo "Installing yay!"
		sudo pacman -S --needed git base-devel --noconfirm
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

	yay -S --noconfirm ansible
	yay -S --noconfirm python-psycopg2
}

debian_setup () {
	sudo apt update -y
	sudo apt install build-essential unzip libreadline-dev curl libfuse2 snapd python3-pip python3-venv ansible libpq-dev python3-dev gzip unzip xz-utils -y
	sudo pip install --upgrade pip
}

macos_setup () {
	which -s brew
	if [[ $? != 0 ]] ; then
		nice_echo "Installing homebrew!"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	else
		nice_echo "Update brew"
		brew update
	fi

	brew install ansible
	brew install postgresql
}

# Setting up system for next tasks
# Ensure that app manager and ansible are installed
# and other dependiencies that are necessary.
system_setup() {
	nice_echo "System setup for:" "$system"

	if [[ "$system" == "Arch Based" ]]; then
		arch_setup
	elif [[ "$system" == "Debian Based" ]]; then
		debian_setup
	elif [[ "$system" == "Darwin" ]]; then
		macos_setup
	fi
}
