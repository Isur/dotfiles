install_with_apt() {
	sudo apt-get install -y $@
}

install_with_snap() {
	sudo snap install $@
}

install_with_yay() {
	yay -S --noconfirm --sudoloop $@
}

install_with_brew () {
	brew install $@
}
