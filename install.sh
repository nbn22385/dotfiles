#!/bin/bash
 
# Install dotfiles as symbolic links using 'stow'
if ! type stow > /dev/null; then echo "ERROR: gnu 'stow' package not installed" && exit 1; fi
stow vim tmux zsh --target "$HOME"
 
# Vim plugin management using minpac
git clone --quiet "https://github.com/k-takata/minpac" "$HOME/.vim/pack/minpac/opt"
vim -E -s +"call minpac#update()" +qall
 
echo "Done setting up dotfiles"
