###############
# Base16 Shell
###############

BASE16_SHELL_PATH="$HOME/.config/base16-shell"
[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL_PATH/profile_helper.sh" ] && \
  source "$BASE16_SHELL_PATH/profile_helper.sh"

#########
# Prompt
#########

autoload -U promptinit; promptinit

source ~/.powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

################
# Options
################

setopt autocd
setopt autopushd
setopt pushdignoredups
setopt correct
setopt globdots
setopt histignoredups
setopt incappendhistory
setopt sharehistory
setopt ignoreeof

HISTFILE="$HOME/.zsh_history"
HISTSIZE=500
SAVEHIST=500

##########
# Keymaps
##########

bindkey -v
bindkey -v "kj" vi-cmd-mode
bindkey "^A" vi-beginning-of-line
bindkey "^E" vi-end-of-line
bindkey "^R" history-incremental-search-backward
bindkey "ç" fzf-cd-widget

# customize up/down arrow history behavior https://superuser.com/a/585004
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-backward-end

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
zstyle ':completion:*' list-suffixes expand prefix suffix

# highlight tab completion options
zstyle ':completion:*' menu select

##########
# Aliases
##########

# cd aliases
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ls aliases
(ls --help 2>&1 | grep -q -- --color) && alias ls='ls --color' || alias ls='ls -G'
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
alias gw='fzf_worktree'
alias lg='lazygit'

# ripgrep aliases
alias rg='rg --hidden --smart-case --glob "!**/.git/**"'

# tmux aliases
alias tmux='export SHELL=$(which zsh); tmux -2 -u'
if [[ $TMUX ]]; then
  alias clear='clear && tmux clear-history'
fi

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
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export TZ='America/New_York'

export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'
export FZF_DEFAULT_OPTS="
  --bind='ctrl-d:toggle-preview'
  --border=sharp
  --color=gutter:-1
  --height=40%
  --history='$HOME/.fzf_history'
  --info=inline 
  --layout=reverse
  --marker='✓'
  --multi
  --pointer='▶'
  --preview='bat --color=always --line-range :500 {}'
  --preview-window=hidden"
export FZF_ALT_C_COMMAND='fd --type d . --color=never'
export FZF_ALT_C_OPTS='--preview "tree -C {} | head -100"'
export FZF_CTRL_R_OPTS="--preview 'echo {}'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--select-1 --exit-0'

# Fzf shell support
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

############
# Functions
############

# cd into a directory selected via fzf
fzf_change_directory() {
  local directory=$(
  fd --type d --hidden --exclude ".git" | \
    fzf --prompt="Change directory: " --query="$1" --no-multi --select-1 --exit-0 \
    --preview 'tree -C {} | head -100'
  )
  if [[ -n $directory ]]; then
    cd "$directory"
  fi
}

# edit selected file(s) via fzf
fzf_find_edit() {
  local file=$(fzf --prompt="Edit file(s): " --query="$1" --select-1 --exit-0)
  if [[ -n $file ]]; then
    $EDITOR $(echo $file)
  fi
}

# change the base16-shell theme selected via fzf
fzf_base16_theme() {
  echo "Current theme:" $BASE16_THEME
  local theme=$(
  alias | 
    awk -F'base16_|=' '/^base16_/ {print $2}' | 
    fzf --prompt="Base16 theme: " --query="$1" --exit-0
  )
  if [[ -n $theme ]]; then
    echo "Theme set to:" $theme
    eval base16_$theme
  fi
}

# change git worktree via fzf (https://peppe.rs/posts/curing_a_case_of_git-UX)
fzf_worktree() {
  set -o pipefail
  local worktree=$(
  git worktree list |
    fzf --preview='git log --oneline -n10 {2}' --query="$1" --exit-0 |
    awk '{print $1}'
  )
  if [[ -n $worktree ]]; then
    if [ "$worktree" = $(pwd) ]; then
      echo "Git worktree already set to '$worktree'"
    else
      cd $worktree && echo "Changed git worktree to '$worktree'"
    fi
  fi
}

# checkout git branch via fzf (https://polothy.github.io/post/2019-08-19-fzf-git-checkout)
fzf_git_checkout_branch() {
  git rev-parse HEAD > /dev/null 2>&1 || return

  local branch=$(git branch --color=always --all --sort=-committerdate |
    grep -v HEAD |
    fzf --height 50% --ansi --no-multi --preview-window right:65% \
    --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
    sed "s/.* //"
  )

  if [[ "$branch" = "" ]]; then
    echo "No branch selected."
    return
  fi

  # If branch name starts with 'remotes/' then it is a remote branch. By
  # using --track and a remote branch name, it is the same as:
  # git checkout -b branchName --track origin/branchName
  if [[ "$branch" = 'remotes/'* ]]; then
    git checkout --track $branch
  else
    git checkout $branch;
  fi
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
