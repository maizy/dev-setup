# locale
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# go
export GOPATH="${HOME}/Dev/go_ext:${HOME}/Dev/go"

# venv (+ os specific bellow)
export WORKON_HOME=~/Dev/venv
export PROJECT_HOME=~/Dev/venv_projects
export VIRTUALENVWRAPPER_HOOK_DIR=~/Dev/venv_hooks

# editors (+ os specific bellow)
export EDITOR=/usr/bin/nano

# os x specific
if [[ `uname` == 'Darwin' ]]; then
    export PATH="${HOME}/bin:/usr/local/sbin:/usr/local/bin:${PATH}"

    #docker
    export VM_DISK_SIZE=20000
    export DOCKER_HOST=tcp://localhost:4243

# linux specific
elif [[ `uname` == 'Linux' ]]; then
    export PATH="${HOME}/bin:${PATH}"

    # editors
    export SELECT_EDITOR='nano'
    export VISUAL='nano'
    export SVN_EDITOR='nano'
fi
