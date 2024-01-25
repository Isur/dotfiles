arch_docker () {
	yay -S docker docker-compose docker-buildx --noconfirm

	sudo getent group docker || sudo groupadd docker
	sudo usermod -aG docker $USER
	sudo systemctl enable docker
}

debian_docker () {
	sudo apt update
	sudo apt install ca-certificates curl gnupg -y
	sudo install -m 0755 -d /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	sudo chmod a+r /etc/apt/keyrings/docker.gpg
	echo \
		"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
		$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
		sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

	sudo apt update
	sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

	sudo getent group docker || sudo groupadd docker
	sudo usermod -aG docker $USER
	sudo systemctl enable docker
}

macos_docker () {
	brew install --cask docker
}

install_docker () {
	nice_echo "Installing docker"

	if [[ "$system" == "Arch Based" ]]; then
		arch_docker
	elif [[ "$system" == "Debian Based" ]]; then
		debian_docker
	elif [[ "$system" == "MacOS" ]]; then
		macos_docker
	fi	
}
