#!/bin/bash

UP=$1
upgrade=""
if [ "$UP" == "up" ];then
    upgrade='--upgrade'
fi

function i {
    /usr/local/bin/pip3 install $1 $2
    # overwrite 3.x binaries
    /usr/local/bin/pip install $1 $2
}

function i2 {
    /usr/local/bin/pip install $1 $2
}

i $upgrade setuptools
i $upgrade pip
i $upgrade bpython
i $upgrade ipython
i $upgrade lxml
i $upgrade pep8

i2 $upgrade fabric
i2 $upgrade pync

# TODO: auto create py3 binaries in /usr/local/bin
# TODO: setup.py develop
ln -sf ~/Dev/dev-setup/python-packages/* /usr/local/lib/python2.7/site-packages/