#!/usr/bin/env bash

STOW_FOLDERS="bash config tmux vim zsh"

if [ "$1" = "--install-dependencies" ]; then ./extras/dependencies.sh; fi

# Check that stow is installed on the system
if ! type stow > /dev/null; then echo "ERROR: gnu 'stow' package not installed" && exit 1; fi

# First unstow then stow the symlinks
stow --no-folding --restow --target="$HOME" $STOW_FOLDERS

# Install vim plugins
git clone --quiet https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac > /dev/null 2>&1
vim --noplugin -n +PackUpdateAndQuit

echo "Done setting up dotfiles."
