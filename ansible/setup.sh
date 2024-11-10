#!/bin/bash

REPO_URL="https://github.com/Isur/dotfiles.git"
DOTFILES="$HOME/dotfiles"
ANSIBLE_DIR="$HOME/dotfiles/ansible"
REQUIREMENTS_FILE="$ANSIBLE_DIR/collections.yaml"

# Pull the latest code
ansible-pull -U "$REPO_URL" -d "$DOTFILES"

# Install collections specified in requirements.yml
if [ -f "$REQUIREMENTS_FILE" ]; then
    ansible-galaxy collection install -r "$REQUIREMENTS_FILE" -p "$ANSIBLE_DIR/collections"
fi

# Run ansible-pull with the environment variable for collections
export ANSIBLE_COLLECTIONS_PATHS="$ANSIBLE_DIR/collections"
ansible-pull -U "$REPO_URL" -d "$ANSIBLE_DIR" -i play.yml --vault-password-file $HOME/.vault_pass
