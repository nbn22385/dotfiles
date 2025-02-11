#!/usr/bin/env bash

# Download and extract the latest Neovim to /tmp
wget -qO- https://github.com/neovim/neovim/releases/latest/download/nvim-macos-x86_64.tar.gz | gunzip | tar xvf - -C /tmp

# Move Neovim to /usr/local
sudo mv /tmp/nvim-macos-x86_64 /usr/local/nvim

# Symlink the executable
sudo ln -s /usr/local/nvim/bin/nvim /usr/local/bin/nvim
