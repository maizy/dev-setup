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


# venv
export WORKON_HOME=~/Dev/venv
export PROJECT_HOME=~/Dev/venv_projects
export VIRTUALENVWRAPPER_HOOK_DIR=~/Dev/venv_hooks

# go
export GOPATH="${HOME}/Dev/go_ext:${HOME}/Dev/go"

# locale
export LANG="en_US"
export LC_ALL="en_US.UTF-8"

# ----------------------------------------------------
# functions

# git
function trust_me_git
{
    CUR_BR=`git br | grep -r '^\*\ .*$' | awk '{print $2}'`
    git fetch
    git clean -df
    git co -f
    git reset --hard "origin/${CUR_BR}"
}

# navigation
function cdd {
    builtin \cd "${HOME}/Dev/$@"
}

_cdd_complete () {
    local cur="$2"
    COMPREPLY=( $(cdd && compgen -d -- "${cur}" ) )
}

complete -o nospace -F _cdd_complete -S/ cdd

