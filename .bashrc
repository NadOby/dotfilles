#!/bin/bash
# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

################################################################################
# History management
# History of the user is synchronised after every enter press
# History file is cleaned up on every login.
shopt -s histappend
export HISTSIZE=20000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth:erasedups
export PROMPT_COMMAND="history -n; history -w; history -c; history -r"
TMPFILE=$(mktemp); tac "${HISTFILE}" | sed -e 's/[[:space:]]*$//' | awk '!x[$0]++' | tac > "${TMPFILE}" ; cat "${TMPFILE}" > "${HISTFILE}" ; rm "${TMPFILE}"; unset TMPFILE

################################################################################
# Dev envs configuration
# Python with pyenv
export PYENV_ROOT="$HOME/.pyenv"

# Golang
export GOROOT=$HOME/.go
export GOPATH="$GOROOT/packages"


################################################################################
# Exports

#OSTYPE=`uname -o`
export VISUAL="vim"
export PATH="$PYENV_ROOT/bin:$GOROOT/bin:$GOPATH/bin:$PATH"
# setting for building python under pyenv as framework under macosx 
#export PYTHON_CONFIGURE_OPTS="--enable-framework"

# Pyenv initialisation sholuld be done after setting $PATH
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
################################################################################
# Shell options

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

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
# Aliases 
alias a=alias 
a ls='ls -G --color=yes'
a stmpdat='date +%Y%m%d'
a stmpdatime='date +%Y%m%d%H%M'
a nochkssh='ssh -q -o StrictHostKeyChecking=no -o ConnectTimeout=10'
a config="/usr/bin/git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME"
a cdw='cd ~/work/'
a cds='cd ~/src/'
a cdt='cd ~/tmp/'

################################################################################
# Define PROMPT to be nice and colorful by hostname
if [ "$HOSTNAME" == "oburaak" ] || [ "$HOSTNAME" == "munchkin" ]
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

}

parse_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

################################################################################
# WSL configuration should be set only when running under WSL
if grep -qE "(Microsoft|WSL)" /proc/version &> /dev/null
then
    # umask magic
    if [ "$(umask)" = "0000" ]
	then
		umask 022
	fi

    # Docker is running under Hyperv and acessible by TCP
    export DOCKER_HOST=tcp://localhost:2375
    # Some Xserver should be enabled DISPLAY is set for X GUI apps
    export DISPLAY=:0
    # To prevent blured fonts on HiDPI displays
    # https://superuser.com/questions/1370361/blurry-fonts-on-using-windows-default-scaling-with-wsl-gui-applications-hidpi
    export GDK_SCALE=0.5
    export GDK_DPI_SCALE=2
fi

################################################################################
# NPM installation through NVM
export NVM_DIR="$HOME/.nvm"
# shellcheck source=/home/evgeniy/.nvm/nvm.sh
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# shellcheck source=/home/evgeniy/.nvm/bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

################################################################################
# Bunker
export TILLER_NAMESPACE=tiller
