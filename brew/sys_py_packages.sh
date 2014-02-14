#!/bin/bash

UP=$1
upgrade=""
if [ "$UP" == "up" ];then
    upgrade='--upgrade'
fi

function i {
    CFLAGS=-I$(brew --prefix)/include LDFLAGS=-L$(brew --prefix)/lib pip2.6 install $1 $2
    #pip3.1 install $1 $2
    CFLAGS=-I$(brew --prefix)/include LDFLAGS=-L$(brew --prefix)/lib pip3.2 install $1 $2

    CFLAGS=-I$(brew --prefix)/include LDFLAGS=-L$(brew --prefix)/lib /usr/local/bin/pip3 install $1 $2

    # overwrite all binaries with 2.7 versions
    CFLAGS=-I$(brew --prefix)/include LDFLAGS=-L$(brew --prefix)/lib /usr/local/bin/pip install $1 $2
}

function i2 {
    CFLAGS=-I$(brew --prefix)/include LDFLAGS=-L$(brew --prefix)/lib pip2.6 install $1 $2

    # overwrite all binaries with 2.7 versions
    CFLAGS=-I$(brew --prefix)/include LDFLAGS=-L$(brew --prefix)/lib /usr/local/bin/pip install $1 $2
}

i $upgrade setuptools
i $upgrade pip
i $upgrade cython
i $upgrade bpython
i $upgrade ipython
i $upgrade lxml
i $upgrade pep8
i $upgrade nose
i $upgrade virtualenv
i $upgrade docutils

# virtualenvwrapper not supported in py3.2
CFLAGS=-I$(brew --prefix)/include LDFLAGS=-L$(brew --prefix)/lib pip2.6 install $1
CFLAGS=-I$(brew --prefix)/include LDFLAGS=-L$(brew --prefix)/lib /usr/local/bin/pip3 install $1 virtualenvwrapper
CFLAGS=-I$(brew --prefix)/include LDFLAGS=-L$(brew --prefix)/lib /usr/local/bin/pip install $1 virtualenvwrapper

i2 $upgrade fabric
i2 $upgrade pync

# TODO: auto create some py3 binaries in /usr/local/bin

# TODO: setup.py develop
ln -sf ~/Dev/dev-setup/python-packages/* /usr/local/lib/python2.7/site-packages/
