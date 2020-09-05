#!/bin/bash
 
# Install dotfiles as symbolic links using 'stow'
if ! type stow > /dev/null; then echo "ERROR: gnu 'stow' package not installed" && exit 1; fi
stow --no-folding vim tmux zsh --target "$HOME"

# Vim plugin management using minpac
git clone --quiet https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
vim --noplugin +PackUpdateAndQuit

echo "Done setting up dotfiles."
