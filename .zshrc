# Path to your oh-my-zsh installation.
export ZSH=/Users/mohit/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="remy"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode history-substring-search fasd)
export EDITOR='vim'

if [[ $TERM_PROGRAM == 'iTerm.app' && -z $TMUX ]]; then export NVIM_TUI_ENABLE_TRUE_COLOR=1; fi

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.cargo/bin"
# required for tern-jsclass to work
export NODE_PATH="/usr/local/lib/node_modules"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

source ~/.oh-my-zsh/plugins/zsh-autosuggestions/autosuggestions.zsh
# Enable autosuggestions automatically.
AUTOSUGGESTION_HIGHLIGHT_COLOR='fg=242'
zle-line-init() {
    zle autosuggest-start
}
zle -N zle-line-init
# bind the key for the completion
bindkey '^f' vi-forward-blank-word
bindkey '^e' end-of-line
# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases

#this line is for the macvim to funtion properly Don't remove it
# python stuff
# export DYLD_FORCE_FLAT_NAMESPACE=1
export LDFLAGS=-L/usr/local/opt/sqlite/lib
export CPPFLAGS=-I/usr/local/opt/sqlite/include
# tell the virtualenv to lay off prompt
VIRTUAL_ENV_DISABLE_PROMPT=true
# set where virutal environments will live
export WORKON_HOME=$HOME/.virtualenvs
# ensure all new environments are isolated from the site-packages directory
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
# use the same directory for virtualenvs as virtualenvwrapper
export PIP_VIRTUALENV_BASE=$WORKON_HOME
# makes pip detect an active virtualenv and install to it
export PIP_RESPECT_VIRTUALENV=true
if [[ -r /usr/local/bin/virtualenvwrapper.sh ]]; then
    source /usr/local/bin/virtualenvwrapper.sh
else
    echo "WARNING: Can't find virtualenvwrapper.sh"
fi
# source custom functions
source $ZSH/scripts/githubCreate.sh

alias gst="git status"
alias glo="git log"
alias gdc="git diff --cached"
alias gco="git checkout"
alias gbr="git branch"
alias ls="ls -aF -G"
alias gpu="git pull"
alias gdf="git diff"
alias gdfw="git diff --color-words"
alias gph="git push -u"
alias lsd="ls -d"
alias gclean="git clean -df"
alias githubCreate=githubCreate
# only for gymnasium project
alias tag="git ls-files applications/gymnasium/src | ctags --tag-relative -L - -f .git/tags --languages=js,html"
# this is in case of error of opening macvim
# http://stackoverflow.com/questions/17537871/macvim-failed-to-start-after-connecting-to-a-extra-display-and-disconnected
alias clearvim='rm -r ~/Library/Preferences/*.vim.*'
alias editHosts='sudo mvim -f /etc/hosts && dscacheutil -flushcache'

# roadmunk alias
alias rminspect='docker-compose run --rm --service-ports app node --inspect=0.0.0.0 server.js -w1'
# for debugging server side while running client side tests.
alias rminspectclient='docker-compose run --service-ports --rm app node server.js --inspect-tests'
# stops at first line
alias rminspectstart='docker-compose run --rm --service-ports app node --inspect --debug-brk server.js -w1'


# this lets you view man pages in vim NOT KIDDING
export MANPAGER="/bin/sh -c \"unset MANPAGER;col -b -x | \
    vim --cmd 'let g:plugins=2' --noplugin -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
    -c 'set laststatus=0' -c 'set nonumber' \
    -c 'set nocursorcolumn' -c 'set nocursorline' \
    -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

# inserting some of the cool custom functions
setopt correct
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# FZF functions
__gsel(){
  command git branch \
    2> /dev/null | sed 1d | cut -b3- | $(__fzfcmd) -m | while read item; do
    printf '%q ' "$item"
  done
  echo
}

fzf-git-widget() {
  LBUFFER="${LBUFFER}$(__gsel)"
  zle redisplay
}
zle     -N   fzf-git-widget
bindkey '^g' fzf-git-widget

# // changing fzf FZF_DEFAULT_COMMAND breaks things in fzf.vim.
# export FZF_DEFAULT_COMMAND='ag --hidden --nocolor -l -g ""'
export FZF_CTRL_T_COMMAND='ag --hidden --nocolor -l -g ""'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# for chruby and ruby yuckk
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
chruby ruby-2.4.1

source ~/.tmuxinator/tmuxinator.zsh



# set options here for unique history
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP
