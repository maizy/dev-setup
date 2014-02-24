#!/bin/bash

mkdir -p /tmp/brew-install
cd /tmp/brew-install

brew install bash
brew install bash-completion
brew install mc
brew install zsh

brew install git
brew install tig
brew install mercurial
brew install svn

brew install python3

brew install python
ln -sf /usr/local/python ~/bin/python2.7
pip install yolk
ln -sf /usr/local/bin/yolk ~/bin/yolk2.7


brew install curl --with-ares
brew install wget
brew install nmap
brew install mcrypt
brew install homebrew/dupes/rsync
brew install p7zip
brew install xz
brew install lzo
brew install ssh-copy-id

brew install watch
brew install gnu-getopt
brew install grep

brew install htop
brew install iperf
brew install iftop
brew install httperf
brew install netcat
brew install memtester

brew install autoconf
brew install automake
brew install cmake

brew install pcre

brew install maven
brew install scala --with-docs
brew install sbt
brew install play

brew install nginx
brew install postgres

brew install nodejs

brew install libxml2
brew install libxslt
brew install libyaml
brew install openssl
brew install sqlite
brew install zmq
brew install gnutls
brew install expat
brew install ncurses
brew install libmemcached


# various python versions

brew tap homebrew/versions

function oldpy {
    VER_DOT=$1
    VER_MAIN=${1:0:1}
    VER=${VER_DOT/./}

    echo -e '\n------------------------\nINSTALL PYTHON '$VER_DOT'\n'

    brew install "python$VER"
    ln -sf /usr/local/Cellar/python$VER/$VER_DOT.*/bin/python$VER_DOT $HOME/bin/python$VER_DOT
    if [ ! -f $HOME/bin/easy_install-$VER_DOT ]; then
        wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | "python$VER_DOT"
    else
        echo "skip easy_install-$VER_DOT, alredy installed"
    fi
    ln -sf /usr/local/Cellar/python$VER/$VER_DOT.*/bin/easy_install-$VER_DOT $HOME/bin/easy_install-$VER_DOT
    "easy_install-$VER_DOT" pip
    ln -sf /usr/local/Cellar/python$VER/$VER_DOT.*/bin/pip$VER_DOT $HOME/bin/pip$VER_DOT
    if [ "$VER_MAIN" == "2" ];then
        if [ "`which yolk$VER_DOT`" == "" ]; then
            "pip$VER_DOT" install yolk
        else
            echo "skip yolk$VER_DOT, alredy installed"
        fi
        ln -sf /usr/local/Cellar/python$VER/$VER_DOT.*/bin/yolk $HOME/bin/yolk$VER_DOT
    else
        echo 'yolk supported only in py2.x'
    fi
}

oldpy '2.6'
oldpy '3.1'

brew install python32
ln -sf /usr/local/Cellar/python32/3.2.*/bin/python3.2 ~/bin/python3.2
ln -sf /usr/local/Cellar/python32/3.2.*/bin/pip-3.2 ~/bin/pip3.2
ln -sf /usr/local/Cellar/python32/3.2.*/bin/easy_install-3.2 ~/bin/easy_install-3.2

exit 0

# TODO migrate
gnuplot -x11 -qt

coreutils \
zlib \

makepasswd \
popt \
pypy \


py26-gobject \
py26-openssl \

py27-numpy \



# faac \
# ffmpeg \
# lame \
# mysql55 \
# mysql55-server \
# mysql_select \
# postgresql92 \
# postgresql92-server \
# postgresql_select \
