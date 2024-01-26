work_repos () {
	ansible-vault decrypt ./actions/work_repos.txt --vault-password-file $HOME/dotfiles/.vault_pass
	while IFS= read -r line; do
		arr=($line)
		mkdir -p $HOME/Developer/Clients/${arr[0]}
		(cd $HOME/Developer/Clients/${arr[0]} && git clone ${arr[1]})
	done < $HOME/dotfiles/install/actions/work_repos.txt
	ansible-vault encrypt ./actions/work_repos.txt --vault-password-file $HOME/dotfiles/.vault_pass
}

private_repos () {
	ansible-vault decrypt ./actions/private_repos.txt --vault-password-file $HOME/dotfiles/.vault_pass
	while IFS= read -r line; do
		arr=($line)
		(cd $HOME/Developer/Personal && git clone ${arr[0]})
	done < $HOME/dotfiles/install/actions/private_repos.txt
	ansible-vault encrypt ./actions/private_repos.txt --vault-password-file $HOME/dotfiles/.vault_pass
}

