arch_python () {
    yay -S git gzip uznip xz --noconfirm
}

debian_python () {
    sudo apt install git gzip unzip xz -y
}

macos_python () {
    brew install git gzip uznip xz
}

install_proto () {
	nice_echo "Installing proto"

	if [[ "$system" == "Arch Based" ]]; then
		arch_python
	elif [[ "$system" == "Debian Based" ]]; then
		debian_python
	elif [[ "$system" == "Darwin" ]]; then
		macos_python
	fi

    curl -fsSL https://moonrepo.dev/install/proto.sh | bash -s -- --no-profile --yes
}