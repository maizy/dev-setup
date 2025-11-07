# locale
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# go
export GOPATH="${HOME}/Dev/go"


# editors (+ os specific bellow)
export EDITOR=/usr/bin/nano

# os x specific
if [[ `uname` == 'Darwin' ]]; then
    export PATH="${HOME}/bin:/usr/local/sbin:/usr/local/bin:${PATH}"

# linux specific
elif [[ `uname` == 'Linux' ]]; then
    export PATH="${HOME}/bin:${PATH}"

    # editors
    export SELECT_EDITOR='nano'
    export VISUAL='nano'
fi
