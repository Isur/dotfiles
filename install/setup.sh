arch_setup () {
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
	yay -S --noconfirm --sudoloop ansible
}

debian_setup () {
	sudo apt update -y
	sudo apt install build-essential curl libfuse2 snapd python3-pip python3-venv ansible -y
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
}

system_setup() {
	nice_echo "System setup for:" "$system"

	if [[ "$system" == "Arch Based" ]]; then
		arch_setup
	elif [[ "$system" == "Debian Based" ]]; then
		debian_setup
	elif [[ "$system" == "MacOS" ]]; then
		macos_setup
	fi	
}
