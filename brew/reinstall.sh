#!/bin/bash

brew install bash
brew install bash-completion
brew install mc
brew install zsh

brew install git
brew install tig
brew install mercurial

brew install python
ln -sf /usr/local/python ~/bin/python2.7
brew install python3
ln -sf /usr/local/python ~/bin/python3.3

brew install curl --with-ares
brew install wget
brew install nmap

brew install htop
brew install iperf
brew install iftop
brew install httperf

brew install autoconf
brew install automake
brew install cmake

brew install pcre

brew install maven
brew install scala
brew install sbt
brew install play

brew install nginx
brew install postgres

brew install nodejs


brew tap homebrew/versions

function oldpy {
    VER_DOT=$1
    VER=${VER_DOT/./}

    brew install "python$VER"
    ln -sf /usr/local/Cellar/python$VER/$VER_DOT.*/bin/python$VER_DOT $HOME/bin/python$VER_DOT
    if [ "`which easy_install-$VER_DOT`" == "" ]; then
        wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | "python$VER_DOT"
    else
        echo "skip easy_install-$VER_DOT, alredy installed"
    fi
    ln -sf /usr/local/Cellar/python$VER/$VER_DOT.*/bin/easy_install-$VER_DOT $HOME/bin/easy_install-$VER_DOT
    "easy_install-$VER_DOT" pip
    ln -sf /usr/local/Cellar/python$VER/$VER_DOT.*/bin/pip$VER_DOT $HOME/bin/pip$VER_DOT
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

bzip2 \
coreutils \
expat \
file \
getopt \
gettext \
gmake \
gnutls \
libxml2 \
libxslt \
libyaml \
lzo2 \
m4 \
makepasswd \
mcrypt \
memtester \
ncurses \
netcat \
openssl \
p7zip \
popt \
pypy \
readline \
rsync \
sqlite3 \
subversion \
tig \
watch \
xz \
zlib \
zmq \

py26-cython \
py26-docutils \
py26-gobject \
py26-openssl \
py26-setuptools \

py27-cython \
py27-libxml2 \
py27-numpy \
py27-pygments \
py27-readline \
py27-setuptools \

python32 \
py32-cython \
py32-setuptools \

py33-cython \
py33-setuptools \

# faac \
# ffmpeg \
# lame \
# mysql55 \
# mysql55-server \
# mysql_select \
# postgresql92 \
# postgresql92-server \
# postgresql_select \
