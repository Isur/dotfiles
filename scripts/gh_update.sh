#!/usr/bin/env bash

if [[ "$#" -lt 1 ]]; then
    echo "Usage: $0 <target> [--all]"
    exit 1
fi

update_all="no"
target_dir="$1"

if [[ "$2" == "--all" ]]; then
    update_all="yes"
fi

for org in $target_dir/*; do
    [ -d "$org" ] || continue

    o=$(basename "$org")
    echo ">>> [ $o ] Updating"

    if [ ! "$update_all" == "yes" ]; then
        read -rp "Update $o? [Y/n] " yn
        case "${yn:-Y}" in   # default to "Y" if Enter pressed
            [Yy]* ) ;;
            * ) echo "⏭️  Skipping $o"; continue ;;
        esac
    fi

    for repo in "$org"/*; do
        [ -d "$repo/.git" ] || continue

        r=$(basename "$repo")

        (
            echo "  ↳ Updating $r..."
            cd "$repo"
            git fetch --all --prune --quiet
            git pull --ff-only --quiet
            echo "  ✅ $r updated"
        )
    done

    echo "✅ Finished updating org: $o"
    echo
done

echo "🎉 All updates complete!"

