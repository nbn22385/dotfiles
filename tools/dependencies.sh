#!/bin/bash

# MacOS support
if [ "$(uname)" == "Darwin" ]; then
  echo "Installing dependencies using homebrew..."
  # Make sure we’re using the latest Homebrew
  brew update
  # Upgrade any already-installed formulae
  brew upgrade
  # Install dependencies
  brew install                    \
    bat                           \
    fd                            \
    fzf                           \
    pandoc                        \
    ripgrep                       \
    tmux                          \
    vim --with-override-system-vi
  # install casks
  brew cask install               \
    basictex
  # Remove outdated versions from the cellar.
  brew cleanup
fi

# Ubuntu support
if [ -x "$(command -v apt-get)" ]; then
  apt-get update && apt-get install -y \
    bat             \
    clang-format    \
    clang-tidy      \
    clangd          \
    cmake           \
    fd-find         \
    g++             \
    llvm            \
    ripgrep         \
    tree            \
    universal-ctags \
    vim             \
    zsh
fi
