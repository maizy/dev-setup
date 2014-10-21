#!/bin/bash

UP=$1
upgrade=""
if [ "$UP" == "up" ];then
    upgrade='--upgrade'
fi

function i {

    CFLAGS=-I$(brew --prefix)/include LDFLAGS=-L$(brew --prefix)/lib /usr/local/bin/pip3 install $1 $2

    # overwrite all binaries with 2.7 versions
    CFLAGS=-I$(brew --prefix)/include LDFLAGS=-L$(brew --prefix)/lib /usr/local/bin/pip install $1 $2
}

function i2 {
    # overwrite all binaries with 2.7 versions
    CFLAGS=-I$(brew --prefix)/include LDFLAGS=-L$(brew --prefix)/lib /usr/local/bin/pip install $1 $2
}

# installed by brew
#i $upgrade setuptools
#i $upgrade pip

i $upgrade cython
i $upgrade bpython
i $upgrade ipython
i $upgrade lxml
i $upgrade pep8
i $upgrade nose
i $upgrade virtualenv
i $upgrade docutils
i $upgrade virtualenvwrapper
i $upgrade pythonpy
i $upgrade httpie

i2 $upgrade fabric
i2 $upgrade pync

python ~/Dev/dev-setup/python-packages/setup.py develop
