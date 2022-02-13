#!/usr/bin/env bash

echo "[+] Installing dependencies using pkg"
pkg update && pkg install -y \
  bat      \
  curl     \
  fd       \
  fzf      \
  git      \
  lazygit  \
  nodejs   \
  ripgrep  \
  stow     \
  tmux     \
  tree     \
  vim      \
  wget     \
  zsh

echo "[+] Installing base16-shell"
git clone https://github.com/fnune/base16-shell.git ~/.config/base16-shell > /dev/null 2>&1

echo "[+] Installing powerlevel10k prompt"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k > /dev/null 2>&1
