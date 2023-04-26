#!/usr/bin/env bash

STOW_FOLDERS="config vim zsh"

if [ "$1" = "--install-dependencies" ]; then ./extras/dependencies.sh; fi

# Check that stow is installed on the system
if ! type stow > /dev/null; then echo "ERROR: gnu 'stow' package not installed" && exit 1; fi

# First unstow then stow the symlinks
stow --no-folding --restow --target="$HOME" $STOW_FOLDERS 2>&1 | grep -v "BUG in find_stowed_path"

echo "Done setting up dotfiles."
