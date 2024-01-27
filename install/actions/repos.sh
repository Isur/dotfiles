work_repos () {
	work=$(ansible-vault view ./actions/work_repos.txt --vault-password-file $HOME/dotfiles/.vault_pass)

	while read -r line; do
		arr=($line)
		mkdir -p $HOME/Developer/Clients/${arr[0]}
		(cd $HOME/Developer/Clients/${arr[0]} && git clone ${arr[1]})
	done <<< "$work"
}

private_repos () {
	private=$(ansible-vault view ./actions/private_repos.txt --vault-password-file $HOME/dotfiles/.vault_pass)

	while read -r line; do
		arr=($line)
		(cd $HOME/Developer/Personal && git clone ${arr[0]})
	done <<< "$private"
}
