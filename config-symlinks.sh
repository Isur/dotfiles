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

if [ ! -f "$HOME/.config/btop/themes/catppuccin.theme" ]; then
	echo Creating simlink for btop theme!
	ln -s ~/dotfiles/themes/btop/catppuccin.theme ~/.config/btop/themes/catppuccin.theme
else
	echo Theme for btop already exists!
fi

if [ ! -f "$HOME/.ideavimrc" ]; then
	echo Creating simlink for ideavim config!
	ln -s ~/dotfiles/ideavimrc ~/.ideavimrc
else
	echo ideavim config already exists!
fi

if [ ! -d "$HOME/.config/kitty" ]; then
	echo Creating simlink for kitty config!
	ln -s ~/dotfiles/kitty ~/.config/kitty
else
	echo Config for kitty already exists!
fi
