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
    curl    \
    fd-find \
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

  echo "[+] Installing neovim"
  curl -kLO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
  chmod u+x nvim-linux-x86_64.appimage
  ./nvim-linux-x86_64.appimage --appimage-extract
  rm nvim-linux-x86_64.appimage
  # Exposing nvim globally.
  sudo mv squashfs-root /
  sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
  git clone https://github.com/nbn22385/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

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

