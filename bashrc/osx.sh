#!/bin/bash

export PATH=/opt/local/bin:/opt/local/sbin:/Users/$USER/bin/:$PATH

# HISTORY #######
# don't put duplicate lines in the history
export HISTCONTROL=ignoreboth:erasedups
# set history length
HISTFILESIZE=1000000000
HISTSIZE=1000000

# append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize
# correct minor errors in the spelling of a directory component in a cd command
shopt -s cdspell
# save all lines of a multiple-line command in the same history entry (allows easy re-editing of multi-line commands)
shopt -s cmdhist


export EDITOR=/usr/bin/nano
export LANG="en_US"
export LC_ALL="en_US.UTF-8"
export CLICOLOR=1

alias 'll'='ls -la'
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

export WORKON_HOME=~/Dev/venv
export PROJECT_HOME=~/Dev/venv_projects
export VIRTUALENVWRAPPER_PYTHON=/opt/local/bin/python2.7
export VIRTUALENVWRAPPER_VIRTUALENV=/opt/local/bin/virtualenv-2.7
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--distribute --python=/opt/local/bin/python2.7'

if [ -f '/opt/local/bin/virtualenvwrapper.sh-2.7' ];then
    source /opt/local/bin/virtualenvwrapper.sh-2.7
    has_virtualenv() {
        if [ -e .venv ]; then
            workon `cat .venv`
        fi
    }
    venv_cd () {
        cd "$@" && has_virtualenv
    }
    alias cd="venv_cd"
fi 
