#!/bin/bash

UP=$1
upgrade=""
if [ "$UP" == "up" ];then
    upgrade='--upgrade'
fi

function i {

    CFLAGS=-I$(brew --prefix)/include LDFLAGS=-L$(brew --prefix)/lib /usr/local/bin/pip3 install $1 $2

    # overwrite all binaries with 2.7 versions
    CFLAGS=-I$(brew --prefix)/include LDFLAGS=-L$(brew --prefix)/lib /usr/local/bin/pip2 install $1 $2
}

function i2 {
    # overwrite all binaries with 2.7 versions
    CFLAGS=-I$(brew --prefix)/include LDFLAGS=-L$(brew --prefix)/lib /usr/local/bin/pip2 install $1 $2
}

i2 $upgrade bpython
i2 $upgrade ipython
i2 $upgrade pycodestyle
i $upgrade nose
i2 $upgrade virtualenv
i2 $upgrade virtualenvwrapper
i2 $upgrade httpie

i2 $upgrade fabric
