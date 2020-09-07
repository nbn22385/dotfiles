#!/bin/bash

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
    ripgrep                       \
    tmux                          \
    vim --with-override-system-vi
  # Remove outdated versions from the cellar.
  brew cleanup
fi
