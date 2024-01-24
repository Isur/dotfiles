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
