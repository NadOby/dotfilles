# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

################################################################################
# Exports

#OSTYPE=`uname -o`
export HISTSIZE=20000
export HISTFILESIZE=20000
#export HISTCONTROL=erasedups
export HISTCONTROL=ignoreboth
export VISUAL="vim"
export GOROOT=$HOME/src/go
export GOPATH="$GOROOT/packages"
export PATH=$HOME/bin:$PATH:$GOROOT/bin:$GOPATH/bin:$HOME/.local/bin
# setting for building python under pyenv as framework under macosx 
#export PYTHON_CONFIGURE_OPTS="--enable-framework"

################################################################################
# Shell options

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
shopt -s histappend

################################################################################
# Colors
export C_NC='\e[0m' # No Color
export C_WHITE='\e[0;37m'
export C_B_WHITE='\e[1;37m'
export C_BLACK='\e[0;30m'
export C_B_BLACK='\e[1;30m'
export C_BLUE='\e[0;34m'
export C_L_BLUE='\e[1;34m'
export C_GREEN='\e[0;32m'
export C_L_GREEN='\e[1;32m'
export C_CYAN='\e[0;36m'
export C_L_CYAN='\e[1;36m'
export C_RED='\e[0;31m'
export C_L_RED='\e[1;31m'
export C_PURPLE='\e[0;35m'
export C_L_PURPLE='\e[1;35m'
export C_BROWN='\e[0;33m'
export C_YELLOW='\e[0;33m'
export C_GRAY='\e[0;30m'
export C_L_GRAY='\e[0;37m'

################################################################################
# Aliases global
alias a=alias 
a ls='ls -G --color=yes'
a stmpdat='date +%Y%m%d'
a stmpdatime='date +%Y%m%d%H%M'
a nochkssh='ssh -q -o StrictHostKeyChecking=no -o ConnectTimeout=10'
a config='/usr/bin/git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME'

################################################################################
# Aliases by hostname
if [ "$HOSTNAME" == "oburaak" ]
then
    a cdw='cd ~/work/'
fi

################################################################################
# Define PROMPT to be nice and colorful
if [ "$HOSTNAME" == "oburaak" ]
then
    PS1="\\[$C_L_PURPLE\\]\\D{%F %T} \\[${C_L_GREEN}\\]\\u\\[${C_L_PURPLE}\\]@\\[${C_L_GREEN}\\]\\h:\\[${C_L_BLUE}\\]\\w\\[${C_NC}\\]\$(parse_git_branch)\\n\\$ "
    # enable bash completion in interactive shells
    if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
        # shellcheck disable=SC1091
        . /etc/bash_completion
    fi
else
    PS1='\[\033[1;91m\]\u\[\033[1;31m\]@\[\033[1;91m\]\h:\[\033[1;34m\]\w\[\033[0m\]$(parse_git_branch)\$ '
    # enable bash completion in interactive shells
    if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
        # shellcheck disable=SC1091
        . /etc/bash_completion
    fi
fi

################################################################################
# Dev envs configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

################################################################################
# Soursing stuff

################################################################################
# Function definitions

title() {
    echo -en "\\033]0;$*\\a"
}

myhosts () {
    grep "$1" ~/.hosts
}

hosto () {
    if (($# < 1)) ; then
        echo -ne "\\tUSAGE: hosto [regex]\\n\\n"
        return 1
    fi
    start_cmd="cat $HOME/.ssh/known_hosts "
    for arg ;do
        start_cmd="$start_cmd | grep $arg "
    done
        
    eval "$start_cmd" | awk -F ',' '{print $1}'
    #$start_cmd | awk -F ',' '{print $1}'

}

parse_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

################################################################################
# Bunker
