arch_screenshot_tool () {
	yay -S flameshot --noconfirm
}

debian_screenshot_tool () {
	sudo apt install flameshot -y
}

macos_screenshot_tool () {
	echo
}

install_screenshot_tool() {
	nice_echo "Install screenshot tool"
	mkdir -p $HOME/.config/btop/themes

	if [[ "$system" == "Arch Based" ]]; then
		arch_screenshot_tool
	elif [[ "$system" == "Debian Based" ]]; then
		debian_screenshot_tool
	elif [[ "$system" == "Darwin" ]]; then
		macos_screenshot_tool
	fi	
}
