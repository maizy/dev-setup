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
brew install coreutils
brew install grep

brew install htop
brew install iperf
brew install iftop
brew install httperf
brew install netcat
brew install memtester
brew install pt
brew install ag

brew install autoconf
brew install automake
brew install cmake

brew install pcre

brew install maven
brew install scala --with-docs --with-src
brew install sbt
brew install play22
brew install typesafe-activator

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
