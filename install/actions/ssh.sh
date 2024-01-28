setup_ssh () {
	if [ ! -f "$HOME/dotfiles/.vault_pass" ]; then
		nice_echo "Vault password file not found! Create .vault_pass file with vault password!"
		return 
	fi

	nice_echo "Unpacking ssh keys!"
	mkdir -p $HOME/.ssh

	if [ -f "$HOME/.ssh/config" ]; then
		nice_echo "Backing up ssh config file!"

		if [ -f "$HOME/.ssh/config.bak" ]; then
			rm $HOME/.ssh/config.bak
		fi

		mv $HOME/.ssh/config $HOME/.ssh/config.bak
	fi

	for f in $(ls $HOME/dotfiles/configs/ssh); do
		if [ -f "$HOME/.ssh/$f" ]; then
			nice_echo "File $f already exists! Skipping!"
		else
			nice_echo "Unpacking $f"
			cp $HOME/dotfiles/configs/ssh/$f $HOME/.ssh/$f
			chmod 600 $HOME/.ssh/$f
			ansible-vault decrypt $HOME/.ssh/$f --vault-password-file $HOME/dotfiles/.vault_pass
		fi
	done

	eval `ssh-agent -s`
	ssh-add

	(cd $HOME/dotfiles; git remote remove origin; git remote add origin git@github.com:Isur/dotfiles; git fetch --all; git branch --set-upstream-to=origin/master master)
}
