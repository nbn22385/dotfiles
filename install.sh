#!/bin/bash

# put vim plugins here
plugins=(
  https://github.com/arcticicestudio/nord-vim
  https://github.com/mhinz/vim-startify
  https://github.com/tpope/vim-commentary
  https://github.com/tpope/vim-fugitive
)

# set up vim plugin folders
plugin_root=~/.vim/pack/plugins/start
after_plugin=~/.vim/after/plugin
mkdir -p $plugin_root
mkdir -p $after_plugin

# helper function to clone a vim plugin from a url
get_plugin() {
  local plugin_name=${1##*/}
  local dest=$plugin_root/$plugin_name
  if [[ ! -d $dest ]]
  then
    echo "Installing plugin: '$plugin_name' ..."
    git clone --quiet $1 $dest 
  fi
}

# clone each vim plugin from the list
for p in "${plugins[@]}"; do get_plugin "$p"; done

# install helptags for vim plugins
vim -N -n --noplugin -u NONE -c -sE "helptags ALL" -c q

# install dotfiles as symlinks
dotfiles_dir=$(pwd)
ln -sf $dotfiles_dir/vim/vimrc          ~/.vimrc
ln -sf $dotfiles_dir/vim/statusline.vim ~/.vim/after/plugin
ln -sf $dotfiles_dir/vim/tabline.vim    ~/.vim/after/plugin
ln -sf $dotfiles_dir/zsh/zshrc          ~/.zshrc
ln -sf $dotfiles_dir/zsh/p10k.zsh       ~/.p10k.zsh

echo "Done setting up dotfiles"
