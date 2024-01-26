arch_python () {
	curl https://pyenv.run | bash
}

debian_python () {
	curl https://pyenv.run | bash
}

macos_python () {
	brew install pyenv
}

install_pyenv () {
	nice_echo "Installing pyenv and poetry"

	if [[ "$system" == "Arch Based" ]]; then
		arch_python
	elif [[ "$system" == "Debian Based" ]]; then
		debian_python
	elif [[ "$system" == "Darwin" ]]; then
		macos_python
	fi

	curl -sSL https://install.python-poetry.org | python3 -
	mkdir -p $HOME/.oh-my-zsh/custom/plugins/poetry
	poetry completions zsh > $HOME/.oh-my-zsh/custom/plugins/poetry/_poetry
}
