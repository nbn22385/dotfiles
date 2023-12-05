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
  sudo apt update && sudo apt install -y \
    acpi    \
    bat     \
    cmake   \
    curl    \
    fd-find \
    g++     \
    git     \
    jq      \
    ripgrep \
    stow    \
    tmux    \
    tree    \
    vim     \
    wget    \
    zsh

  # Set up symlinks for bat and fd
  [[ -x "$(command -v batcat)" ]] && sudo ln -sf $(which batcat) /usr/local/bin/bat
  [[ -x "$(command -v fdfind)" ]] && sudo ln -sf $(which fdfind) /usr/local/bin/fd

  echo "[+] Installing fzf"
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf > /dev/null 2>&1
  $HOME/.fzf/install --completion --key-bindings --no-update-rc

  echo "[+] Installing lazygit"
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin && rm lazygit lazygit.tar.gz

  echo "[+] Installing nodejs"
  # From https://github.com/nodesource/distributions#installation-instructions
  sudo apt install -y ca-certificates curl gnupg
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
  NODE_MAJOR=20
  echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
  sudo apt -o Acquire::AllowInsecureRepositories=true update
  sudo apt install -y --allow-unauthenticated nodejs

  echo "[+] Installing clang tools"
  clang_version=15
  sudo apt install -y             \
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
git clone https://github.com/tinted-theming/base16-shell.git $HOME/.config/base16-shell > /dev/null 2>&1

echo "[+] Installing powerlevel10k prompt"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.powerlevel10k > /dev/null 2>&1

if [[ 'zsh' != ${SHELL::-3}* ]]
then
  echo "[+] Setting zsh as the default shell"
  chsh -s $(which zsh)
fi

