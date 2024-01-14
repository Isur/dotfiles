# Others
Things I did not automated yet but use.

# ZSH
ZSH and oh-my-zsh.

## Plugins
git

zsh-fzf-history-search

```bash
git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
```

## Config
Add those lines to the config in `.zshrc` file.

```bash
bindkey -s ^f "tmux-sessionizer\n"
export path="$home/dotfiles/scripts:$path"
```


