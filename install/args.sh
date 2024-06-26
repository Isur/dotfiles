source ./common.sh

system=""
all="no"
wsl="no"

while [[ $# -gt 0 ]]; do
	case "$1" in
		-w|--wsl)
			wsl="yes"
			shift;;
		-a|--all)
			all="yes"
			shift;;
		-h|--help)
			echo "Usage: $0 [-w|--wsl] [-a|--all]"
			exit 0;;
		*)
			echo "Usage: $0 [-w|--wsl] [-a|--all]"
			exit 1;;
	esac
done

if [ "$(uname)" == "Darwin" ]; then
	system="Darwin"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	if [ -f /etc/arch-release ]; then
		system="Arch Based"
	elif [ -f /etc/debian_version ]; then
		system="Debian Based"
	fi
fi

if [ "$system" == "" ]; then
	nice_echo "System not supported"
	exit 1
fi

if [ "$wsl" == "no" ] && [ "$all" == "no" ]; then
		read -p "Install on WSL? [y/N] " -n 1 -r answer
		if [ "$answer" != "${answer#[Yy]}" ] ;then
			wsl="yes"
		else
			wsl="no"
		fi
		echo
fi

if [ "$all" == "no" ]; then
		read -p "Install all? [y/N] " -n 1 -r answer
		if [ "$answer" != "${answer#[Yy]}" ] ;then
			all="yes"
		else
			all="no"
		fi
		echo
fi
