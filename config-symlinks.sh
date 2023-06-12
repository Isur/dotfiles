if [ ! -f "$HOME/.tmux.conf" ]; then
	echo Creating simlink for tmux config!
	ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
else
	echo Tmux config already exists!
fi

if [ ! -d "$HOME/.config/nvim" ]; then
	echo Creating simlink for nvim config!
	ln -s ~/dotfiles/nvim ~/.config/nvim
else
	echo Config for nvim already exists!
fi
