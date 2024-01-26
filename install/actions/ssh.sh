setup_ssh () {
	if [ ! -f "$HOME/dotfiles/.vault_pass" ]; then
		nice_echo "Vault password file not found! Create .vault_pass file with vault password!"
		exit 1
	fi
	nice_echo "Unpacking ssh keys!"
	mkdir -p $HOME/.ssh
	cp -r $HOME/dotfiles/configs/ssh/* $HOME/.ssh
	chmod 600 $HOME/.ssh/*
	ansible-vault decrypt $HOME/.ssh/* --vault-password-file $HOME/dotfiles/.vault_pass
}
