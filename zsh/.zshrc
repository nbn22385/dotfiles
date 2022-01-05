###############
# Base16 Shell
###############

BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
  eval "$("$BASE16_SHELL/profile_helper.sh")"

#########
# Prompt
#########

autoload -U promptinit; promptinit

source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

################
# Shell Options
################

setopt autocd autopushd pushdignoredups
setopt correct
setopt globdots
setopt histignoredups
setopt ignoreeof

##########
# Keymaps
##########

bindkey -v
bindkey -v "kj" vi-cmd-mode
bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line
bindkey '^R' history-incremental-search-backward
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

#############
# Completion
#############

autoload -Uz compinit

if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit;
else
  compinit -C;
fi;

# case insensitive path-completion 
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# partial completion suggestions
zstyle ':completion:*' list-suffixes expand prefix suffix

# highlight tab completion options
zstyle ':completion:*' menu select

##########
# Aliases
##########

# create 'bat' symlink if batcat is the executable name (ubuntu)
[[ -x "$(command -v batcat)" ]] && ln -sf $(which batcat) /usr/local/bin/bat 

# create 'fd' symlink if fdfind is the executable name (ubuntu)
[[ -x "$(command -v fdfind)" ]] && ln -sf $(which fdfind) /usr/local/bin/fd

# cd aliases
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ls aliases
alias l='ls -lFh'       # long list, classify, human readable
alias la='ls -lAFh'     # long list, almost all, classify, human readable
alias lr='ls -tRFh'     # newest first, recursive, classify, human readable
alias lt='ls -ltFh'     # long list, newest first, classify, human readable
alias lrt='ls -lrtFh'   # long list, oldest first, classify, human readable
alias ll='ls -l'        # long list
alias ldot='ls -ld .*'  # long list, non-recursive
alias lS='ls -1FSsh'    # 1 file per line, classify, largest size first

# fzf aliases
alias cf='fzf_change_directory'
alias vf='fzf_find_edit'
alias btheme='fzf_base16_theme'

# git aliases
alias g='_f() { if [[ $# == 0 ]]; then git status -sb; else git "$@"; fi }; _f'
alias gb='fzf_git_checkout_branch'
alias gcmsg='git commit -m'
alias glog='git log --oneline --decorate --graph'
alias gdt='git difftool'
alias gdu='git diff ..@{upstream}'
alias lg='lazygit'

# ripgrep aliases
alias rg='rg --hidden --smart-case --glob "!**/.git/**"'

# tmux aliases
alias tmux='export SHELL=$(which zsh); tmux -2 -u'

# vim aliases
alias v='vim'
alias vs='v -S '
alias vp="cd $HOME/workspaces/\$(ls -lL $HOME/workspaces | grep '^d' | awk '{print \$9}' | fzf) && vim"

# file shortcuts
alias vimrc='vim ~/.vim/vimrc'
alias zshrc='${=EDITOR} ${HOME}/.zshrc'

# htpc
alias openelec='ssh root@192.168.29.140'
alias wake='wakeonlan -i 192.168.29.255 90:FB:A6:8A:73:42'

##########
# Exports
##########

export EDITOR='vim'
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LS_COLORS="ow=01;36"
export TZ='America/New_York'

export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout reverse --info inline --border --pointer "▶" --color=gutter:-1'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "bat --color=always --line-range :500 {}"'
export FZF_ALT_C_COMMAND='fd --type d . --color=never'
export FZF_ALT_C_OPTS='--preview "tree -C {} | head -100"'

# Fzf shell support
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

############
# Functions
############

# cd into a directory selected via fzf
fzf_change_directory() {
  local directory=$(
  fd --type d --hidden --exclude ".git" | \
    fzf --query="$1" --no-multi --select-1 --exit-0 \
    --preview 'tree -C {} | head -100'
  )
  if [[ -n $directory ]]; then
    cd "$directory"
  fi
}

# edit a file selected via fzf
fzf_find_edit() {
  local file=$(
  fzf --query="$1" --no-multi --select-1 --exit-0 \
    --preview 'bat --color=always --line-range :500 {}'
  )
  if [[ -n $file ]]; then
    $EDITOR "$file"
  fi
}

# change the base16-shell theme selected via fzf
fzf_base16_theme() {
  echo "Current theme:" $(grep '  colorscheme' ~/.vimrc_background | sed 's/  colorscheme base16-//g')
  local theme=$(alias | awk -F'base16_|=' '/base16_/ {print $2}' | fzf --exit-0)
  if [[ -n $theme ]]; then
    eval base16_$theme
  fi
}

# checkout git branch via fzf (https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236)
fzf_git_checkout_branch() {
  git rev-parse HEAD > /dev/null 2>&1 || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
    fzf --height 50% --min-height 20 --border --bind ctrl-/:toggle-preview \
    --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' |
    sed 's/^..//' | cut -d' ' -f1 |
    sed 's#^remotes/##'
  }

# create a new directory and enter it
mcd() {
  mkdir -p "$@" && cd "$_";
}

#################
# MacOS-specific
#################

if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH="/usr/local/sbin:$PATH"
  export PATH="/usr/local/opt/llvm/bin:$PATH"
  export LDFLAGS="-L/usr/local/opt/llvm/lib"
  export CPPFLAGS="-I/usr/local/opt/llvm/include"
fi
