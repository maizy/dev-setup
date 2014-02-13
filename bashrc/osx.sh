#!/bin/bash

# PATHs
export PATH=$HOME/bin:/usr/local/bin:$PATH

# PKG alias
alias pkgs='brew search'
alias pkgi='brew install'
alias pkginfo='brew info'


# editors
export EDITOR=/usr/bin/nano


# PS1
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '


# completions
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi


# colors
export CLICOLOR=1


# venv
#export VIRTUALENVWRAPPER_PYTHON=/opt/local/bin/python2.6
#export VIRTUALENVWRAPPER_VIRTUALENV=/opt/local/bin/virtualenv-2.6
#export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--python=/opt/local/bin/python2.6'

#if [ -f '/opt/local/bin/virtualenvwrapper.sh-2.6' ];then
#    . /opt/local/bin/virtualenvwrapper.sh-2.6
#fi
