[ -z "$PS1" ] && return

HISTSIZE=1000
HISTFILESIZE=2000

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias 'lr'="stat -c '%A %a %n' *"
alias 'chx'="chmod +x"
alias 'chmox'="chmod +x"
alias 'fproc'='ps aux | grep --color'
alias 'gkey'='sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com '
alias 'smc'='sudo mc -S darkfar'
alias 'less'='less -r'
alias 'igsvn'='svn --ignore-externals'

if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

export SELECT_EDITOR='nano'
export EDITOR='nano'
export VISUAL='nano'
export SVN_EDITOR='nano'


export WORKON_HOME=~/Dev
export PROJECT_HOME=~/Dev/venv_projects
#export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--distribute --python=/opt/local/bin/python2.7'

if [ -f '/usr/local/bin/virtualenvwrapper.sh' ];then
    . /usr/local/bin/virtualenvwrapper.sh
fi

function trust_me_git 
{
    CUR_BR=`git br | grep -r '^\*\ .*$' | awk '{print $2}'`
    git fetch
    git clean -df
    git co -f
    git reset --hard "origin/${CUR_BR}"
}

function cdd {
    builtin \cd "${HOME}/Dev/$@"
}

_cdd_complete () {
    local cur="$2"
    COMPREPLY=( $(cdd && compgen -d -- "${cur}" ) )
}

complete -o nospace -F _cdd_complete -S/ cdd
