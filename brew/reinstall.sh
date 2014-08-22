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
brew install scala --with-docs --with-src
brew install sbt
brew install play

brew install nginx
brew install postgres

brew install nodejs
brew install lua

brew install boot2docker
brew install docker


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
