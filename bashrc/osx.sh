#!/bin/bash

# PATHs
export PATH=$HOME/bin:/usr/local/sbin:/usr/local/bin:$PATH

# PKG alias
alias pkgs='brew search'
alias pkgi='brew install'
alias pkginfo='brew info'


# editors
export EDITOR=/usr/bin/nano

# PS1
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# terminal title
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\h:\W\a\]$PS1"
    ;;
*)
    ;;
esac

# completions
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi


# colors
export CLICOLOR=1


# venv
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--python=/usr/local/bin/python --no-site-packages'

if [ -f '/usr/local/bin/virtualenvwrapper_lazy.sh' ];then
    . /usr/local/bin/virtualenvwrapper_lazy.sh
fi

# docker
export VM_DISK_SIZE=20000
export DOCKER_HOST=tcp://localhost:4243
