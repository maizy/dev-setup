#!/bin/bash

# PATHs
export PATH=/Users/$USER/bin:/opt/local/bin:/opt/local/sbin:$PATH


# editors
export EDITOR=/usr/bin/nano


# PS1
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '


# completions
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi


# colors
export CLICOLOR=1


# venv
export VIRTUALENVWRAPPER_PYTHON=/opt/local/bin/python2.6
export VIRTUALENVWRAPPER_VIRTUALENV=/opt/local/bin/virtualenv-2.6
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--python=/opt/local/bin/python2.6'

if [ -f '/opt/local/bin/virtualenvwrapper.sh-2.6' ];then
    . /opt/local/bin/virtualenvwrapper.sh-2.6
fi
