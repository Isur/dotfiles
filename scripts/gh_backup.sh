#!/bin/bash

if [[ "$#" -lt 1 ]]; then
    echo "Usage: $0 <target> [--all]"
    exit 1
fi

get_all="no"
target_dir="$1"

if [[ "$2" == "--all" ]]; then
    get_all="yes"
fi

function backup_org() {
    local org="$1"
    echo ">>> [ $org ] Backing up"
    mkdir -p "$target_dir/$org"
    repos=$(gh repo list $org --limit 1000 --json name -q '.[].name')

    for repo in $repos; do
        target="$target_dir/$org/$repo"
        if [ -d "$target/.git" ]; then
            echo "  ↳ Skipping $repo (already exists)"
            continue
        else
            echo "  ↳ Cloning $repo"
            gh repo clone $org/$repo $target -- --quiet
        fi
    done

    echo ">>> [ $org ] Done backing up"
}

orgs=$(gh org list)
user=$(gh api user | jq -r .login)
all="$orgs $user"

for org in $all; do
    if [[ ! "$get_all" == "yes" ]]; then
    read -rp "Backup $org? [Y/n] " yn
    case "${yn:-Y}" in   # default to "Y" if Enter pressed
        [Yy]* ) ;;
        * ) echo "⏭️  Skipping $org"; continue ;;
    esac
    fi
    backup_org $org
done


read -rp "Zip up backup? [Y/n] " yn
case "${yn:-Y}" in   # default to "Y" if Enter pressed
    [Yy]* ) ;;
    * ) exit 0 ;;
esac

zip -r "$target_dir.zip" "$target_dir"
