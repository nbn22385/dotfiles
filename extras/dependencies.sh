#!/bin/bash

# MacOS support
if [[ $OSTYPE == 'darwin'* ]]; then
  # Install Homebrew if necessary
  command -v brew >/dev/null 2>&1 \
    || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo "Installing dependencies using homebrew"
  brew update
  brew bundle --file "extras/Brewfile"

# Ubuntu support
elif [ -x "$(command -v apt)" ]; then
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

else
  echo "No supported package manager was found. Not installing dependencies."
fi
