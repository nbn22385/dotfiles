#!/bin/bash

# MacOS support
if [ -x "$(command -v brew)" ]; then
  echo "Installing dependencies using homebrew..."
  # Make sure we’re using the latest Homebrew
  brew update
  # Upgrade any already-installed formulae
  brew upgrade
  # Install dependencies
  brew install                    \
    bash                          \
    bat                           \
    fd                            \
    fzf                           \
    pandoc                        \
    ripgrep                       \
    skhd                          \
    starship                      \
    stow                          \
    tmux                          \
    vim --with-override-system-vi \
    yabai
  # install casks
  brew cask install               \
    basictex
  # Remove outdated versions from the cellar.
  brew cleanup
fi

# Ubuntu support
if [ -x "$(command -v apt)" ]; then
  echo "Installing dependencies using apt..."
  apt-get update && apt-get install -y \
    bat             \
    clang-format    \
    clang-tidy      \
    clangd          \
    cmake           \
    fd-find         \
    g++             \
    llvm            \
    nodejs          \
    ripgrep         \
    tree            \
    universal-ctags \
    vim             \
    yarnpkg         \
    zsh
fi
