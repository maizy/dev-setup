#!/bin/bash

# PATHs
export PATH=$HOME/.local/bin:$HOME/bin:$PATH

# editors
export SELECT_EDITOR='nano'
export EDITOR='nano'
export VISUAL='nano'
export SVN_EDITOR='nano'

# PKG alias
alias pkgs='apt-cache search'
alias pkgi='sudo apt-get install'


# PS1
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
fi


# colors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# aliases
alias 'lr'="stat -c '%A %a %n' *"
alias 'gkey'='sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com '
alias 'less'='less -r'


# venv
if [ -f '/usr/local/bin/virtualenvwrapper.sh' ];then
    . /usr/local/bin/virtualenvwrapper.sh
fi
