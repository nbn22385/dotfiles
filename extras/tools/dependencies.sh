#!/bin/bash

# MacOS support
if [ -x "$(command -v brew)" ]; then
  echo "Installing dependencies using homebrew"
  # Make sure we’re using the latest Homebrew
  brew update
  # Upgrade any already-installed formulae
  brew upgrade
  # Install dependencies
  brew install                    \
    bash                          \
    bat                           \
    cmake                         \
    llvm                          \
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
  # Install casks
  brew cask install               \
    basictex
  # Remove outdated versions from the cellar.
  brew cleanup
fi

# Ubuntu support
if [ -x "$(command -v apt)" ]; then
  echo "Installing dependencies using apt"
  apt-get update && apt-get install -y \
    cmake   \
    curl    \
    fd-find \
    g++     \
    git     \
    llvm    \
    tmux    \
    tree    \
    vim     \
    zsh

  sudo apt install -y -o Dpkg::Options::="--force-overwrite" \
    bat     \
    ripgrep

  echo "Installing nodejs"
  curl -sL install-node.now.sh | sh

  echo "Installing clang"
  clang_version=12
  sudo apt install \
    clang-${clang_version} \
    clangd-${clang_version} \
    clang-format-${clang_version} \
    clang-tidy-${clang_version} \
    lldb-${clang_version}

  sudo update-alternatives \
    --install /usr/bin/clang                 clang                 /usr/bin/clang-${clang_version} 100 \
    --slave   /usr/bin/clang++               clang++               /usr/bin/clang++-${clang_version}  \
    --slave   /usr/bin/clang-format          clang-format          /usr/bin/clang-format-${clang_version} \
    --slave   /usr/bin/clangd                clangd                /usr/bin/clangd-${clang_version} \
    --slave   /usr/bin/clang-tidy            clang-tidy            /usr/bin/clang-tidy-${clang_version} \
    --slave   /usr/bin/lldb                  lldb                  /usr/bin/lldb-${clang_version}
fi
