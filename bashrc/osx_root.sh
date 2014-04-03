#!/bin/bash

# aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias 'cd..'='cd ..'
alias 'fproc'='ps aux | grep --color'

# history
export HISTCONTROL=ignoreboth:erasedups
HISTSIZE=5000
HISTFILESIZE=10000
shopt -s histappend
shopt -s checkwinsize
shopt -s cmdhist

# locale
export LANG="en_US"
export LC_ALL="en_US.UTF-8"

# PATHs
export PATH=$HOME/bin:/usr/local/bin:$PATH

# editors
export EDITOR=/usr/bin/nano

# PS1
PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h\a\]$PS1"
    ;;
*)
    ;;
esac

# colors
export CLICOLOR=1
