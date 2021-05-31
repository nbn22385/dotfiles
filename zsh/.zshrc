###############
# Base16 Shell
###############

BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
  eval "$("$BASE16_SHELL/profile_helper.sh")"

###################
# Spaceship Prompt
###################

autoload -U promptinit; promptinit

SPACESHIP_GIT_PREFIX=''
SPACESHIP_GIT_SYMBOL=' '
SPACESHIP_GIT_STATUS_PREFIX=' '
SPACESHIP_GIT_STATUS_SUFFIX=''
SPACESHIP_PROMPT_ORDER=(
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  line_sep      # Line break
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

prompt spaceship

# disable bold prompt
() { local z=$'\0' && PROMPT='${${${$(spaceship_prompt)//\%\%/'$z'}//\%B}//'$z'/%%}' }

################
# Shell Options
################

setopt autocd autopushd pushdignoredups
setopt correct
setopt globdots
setopt histignoredups
setopt ignoreeof

#############
# Completion
#############

# enable completion
autoload -Uz compinit && compinit

# case insensitive path-completion 
zstyle ':completion:*' matcher-list \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 

# partial completion suggestions
zstyle ':completion:*' list-suffixes expand prefix suffix 

# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

##########
# Aliases
##########

# create 'bat' symlink if batcat is the executable name (ubuntu)
[[ -x "$(command -v batcat)" ]] && ln -sf $(which batcat) /usr/local/bin/bat 

# create 'fd' symlink if fdfind is the executable name (ubuntu)
[[ -x "$(command -v fdfind)" ]] && ln -sf $(which fdfind) /usr/local/bin/fd

# cd aliases
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
alias gcmsg='git commit -m'
alias glog='git log --oneline --decorate --graph'
alias gdt='git difftool'
alias gdu='git diff ..@{upstream}'
alias lg='lazygit'

# ripgrep aliases
alias rg='rg --smart-case'

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
export FZF_DEFAULT_OPTS='--height 40% --layout reverse --info inline --border'
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
  fd --type d | \
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
  local selection=$(alias | awk -F'base16_|=' '/base16_/ {print $2}' | fzf)
  eval base16_$selection
}

# create a new directory and enter it
mcd() {
  mkdir -p "$@" && cd "$_";
}

