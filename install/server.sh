sudo apt update
sudo apt install fzf ripgrep fd-find curl vim -y
sudo apt install zsh -y

rm -rf $HOME/.oh-my-zsh/
mkdir -p ${ZSH_CUSTOM:=$HOME/.oh-my-zsh/custom}/plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

mv $HOME/.zshrc $HOME/.zshrc.bak 

echo 'export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="bira"
plugins=(zsh-fzf-history-search zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
export EDITOR="vim"
' >> $HOME/.zshrc

read -p "Do you want to install docker? [y/N] " -r answer

if [[ $answer =~ ^[Yy]$ ]]; then
	sudo apt install ca-certificates curl gnupg -y
	sudo install -m 0755 -d /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	sudo chmod a+r /etc/apt/keyrings/docker.gpg
	echo \
		"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
		$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
		sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

	sudo apt update
	sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

	curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

	sudo getent group docker || sudo groupadd docker
	sudo usermod -aG docker $USER
	sudo systemctl enable docker
fi
