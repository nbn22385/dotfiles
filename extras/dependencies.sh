#!/usr/bin/env bash

sudo()
{
  [[ $EUID = 0 ]] || set -- command sudo "$@"
  "$@"
}

# MacOS support
if [[ $OSTYPE == 'darwin'* ]]; then
  # Install Homebrew if necessary
  command -v brew >/dev/null 2>&1 \
    || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo "[+] Installing dependencies using homebrew"
  brew update
  brew bundle --file "extras/Brewfile"

  # VSCodium extensions
  codium                                   \
    --install-extension ms-vscode.cpptools \
    --install-extension ulwlu.elly         \
    --install-extension xaver.clang-format

# Ubuntu support
elif [ -x "$(command -v apt)" ]; then

  echo "[+] Installing dependencies using apt"
  sudo apt-get update && sudo apt-get install -y \
    cmake   \
    curl    \
    fd-find \
    g++     \
    git     \
    llvm    \
    stow    \
    tmux    \
    tree    \
    vim     \
    zsh

  sudo apt install -y -o Dpkg::Options::="--force-overwrite" \
    bat     \
    ripgrep

  # Allow correct execution of bat and fd
  [[ -x "$(command -v batcat)" ]] && sudo ln -sf $(which batcat) /usr/local/bin/bat 
  [[ -x "$(command -v fdfind)" ]] && sudo ln -sf $(which fdfind) /usr/local/bin/fd

  echo "[+] Installing fzf"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf > /dev/null 2>&1
  ~/.fzf/install --completion --key-bindings --no-update-rc

  echo "[+] Installing lazygit"
  curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest \
    | jq -r ".assets[] | select(.name | contains(\"Linux_x86_64\")) | .browser_download_url" \
    | wget --no-check-certificate -i - \
    && tar -xzf lazygit_*_Linux_x86_64.tar.gz \
    && sudo cp lazygit /usr/local/bin \
    && rm lazygit*

  echo "[+] Installing nodejs"
  curl -fsSL https://deb.nodesource.com/setup_17.x | bash -
  sudo apt-get install -y nodejs

  echo "[+] Installing clang"
  clang_version=12
  sudo apt install                \
    clang-${clang_version}        \
    clangd-${clang_version}       \
    clang-format-${clang_version} \
    clang-tidy-${clang_version}   \
    lldb-${clang_version}

  sudo update-alternatives                                                              \
    --install /usr/bin/clang        clang        /usr/bin/clang-${clang_version} 100    \
    --slave   /usr/bin/clang++      clang++      /usr/bin/clang++-${clang_version}      \
    --slave   /usr/bin/clang-format clang-format /usr/bin/clang-format-${clang_version} \
    --slave   /usr/bin/clangd       clangd       /usr/bin/clangd-${clang_version}       \
    --slave   /usr/bin/clang-tidy   clang-tidy   /usr/bin/clang-tidy-${clang_version}   \
    --slave   /usr/bin/lldb         lldb         /usr/bin/lldb-${clang_version}

else
  echo "[!] No supported package manager was found. Not installing dependencies."
fi

echo "[+] Installing base16-shell"
git clone https://github.com/fnune/base16-shell.git ~/.config/base16-shell > /dev/null 2>&1

echo "[+] Installing powerlevel10k prompt"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k > /dev/null 2>&1

if [[ 'zsh' != ${SHELL::-3}* ]]
then
  echo "[+] Setting zsh as the default shell"
  chsh -s $(which zsh)
fi

