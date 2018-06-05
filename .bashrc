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
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

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
# Aliasese

alias a=alias 
a ls='ls -G'
a stmpdat='date +%Y%m%d'
a stmpdatime='date +%Y%m%d%H%M'
a ssh='ssh -4 -A'
a nochkssh='ssh -A -q -o StrictHostKeyChecking=no -o ConnectTimeout=10'
a config="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

################################################################################
# Define PROMPT to be nice and colorful

parse_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

if [ "$HOSTNAME" == "maharishi" ]
then
    PS1="\\[$C_L_PURPLE\\]\\D{%F %T} \\[${C_L_GREEN}\\]\\u\\[${C_L_PURPLE}\\]@\\[${C_L_GREEN}\\]\\h:\\[${C_L_BLUE}\\]\\w\\[${C_NC}\\]\$(parse_git_branch)\\n\\$ "
    # enable bash completion in interactive shells
    if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
        # shellcheck disable=SC1090
        . "$(brew --prefix)/etc/bash_completion"
    fi

    export GOPATH="$HOME/src/go"
    export PATH=$PATH:~/go/bin
    export GITHUB_HOST=git.ouroath.com
    a git=hub
    a cdwm='cd ~/work/moneyball'
    a cdwp='cd ~/work/pinball'
    a julia='/Applications/JuliaPro-0.6.2.1.app/Contents/Resources/julia/Contents/Resources/julia/bin/julia'
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

function title()
{
    echo -en "\\033]0;$*\\a"
}

myhosts () {
    grep "$1" ~/.hosts
}
################################################################################
# Bunker

#PROMPT_COMMAND='history -n; history -a;' 
# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='history -n; history -a; echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    PROMPT_COMMAND='history -n; history -a;' 
#    ;;
#*)
    #    ;;
    #esac

