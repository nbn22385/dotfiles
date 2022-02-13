#!/usr/bin/env bash

echo "[+] Installing dependencies using pkg"
pkg update && pkg install -y \
  bat      \
  cmake    \
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

  # echo "[+] Installing clang"
  # clang_version=12
  # sudo apt install                \
  #   clang-${clang_version}        \
  #   clangd-${clang_version}       \
  #   clang-format-${clang_version} \
  #   clang-tidy-${clang_version}   \
  #   lldb-${clang_version}

  # sudo update-alternatives                                                              \
  #   --install /usr/bin/clang        clang        /usr/bin/clang-${clang_version} 100    \
  #   --slave   /usr/bin/clang++      clang++      /usr/bin/clang++-${clang_version}      \
  #   --slave   /usr/bin/clang-format clang-format /usr/bin/clang-format-${clang_version} \
  #   --slave   /usr/bin/clangd       clangd       /usr/bin/clangd-${clang_version}       \
  #   --slave   /usr/bin/clang-tidy   clang-tidy   /usr/bin/clang-tidy-${clang_version}   \
  #   --slave   /usr/bin/lldb         lldb         /usr/bin/lldb-${clang_version}

  echo "[+] Installing base16-shell"
  git clone https://github.com/fnune/base16-shell.git ~/.config/base16-shell > /dev/null 2>&1

  echo "[+] Installing powerlevel10k prompt"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k > /dev/null 2>&1

# if [[ 'zsh' != ${SHELL::-3}* ]]
# then
#   echo "[+] Setting zsh as the default shell"
#   chsh -s $(which zsh)
# fi

