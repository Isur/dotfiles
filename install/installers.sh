install_with_apt() {
	sudo apt-get install -y $1
}

install_with_snap() {
	sudo snap install $1
}

install_with_yay() {
	yay -S --noconfirm --sudoloop $1
}

install_with_brew () {
	brew install $1
}

install_with_brew_cask () {
	brew install --cask $1
}
