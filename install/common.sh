nice_echo () {
	echo "------------------------------------------------------------"
	for i in "$@"
	do
		echo "$i"
	done
	echo "------------------------------------------------------------"
}

create_symlink () {
	what="$1"
	from="$HOME/dotfiles/configs/$2"
	to="$HOME/$3"

	echo "Trying to create symlink: $what:" 
	echo "$from -> $to"
	if [ -L "$to" ]; then
		unlink "$to"
	fi

	if [ ! -e "$to" ]; then
		ln -s "$from" "$to"
		echo "Symlink created: $what"
		return 0
	fi

	read -p "Do you want to overwrite $what? [y/N] " -n 1 -r answer
	echo
	if [[ $answer =~ ^[Yy]$ ]]; then
		read -p "Do you want to backup $what? [y/N] " -n 1 -r answer2
		echo
		if [[ $answer2 =~ ^[Yy]$ ]]; then
			if [ -e "$to.bak" ]; then
				rm -rf "$to.bak"
			fi
			mv "$to" "$to.bak"
			echo "Backup created: $what"
		fi
		ln -sf "$from" "$to"
		echo "Symlink created: $what"
		return 0
	else
		echo "Symlink not created: $what"
		return 0
	fi
}

ask_action () {
	if [ "$all" == "yes" ]; then
		$2
	else
		nice_echo "Do you want to:" "$1?" "[y/N]"
		read -n 1 -r answer
		echo
		if [[ $answer =~ ^[Yy]$ ]]; then
			$2
			nice_echo "Finished: $1"
		else 
			nice_echo "Skipped: $1"
		fi
	fi
}
