#!/usr/bin/env bash
#
# Reinstall all macports packages
#

sudo port install git-core +bash_completion +doc +svn +credential_osxkeychain +python27
sudo port install gnuplot -x11 -qt
sudo port install \
    autoconf \
    automake \
    bash \
    bash-completion \
    bpython_select \
    bzip2 \
    cmake \
    coreutils \
    curl \
    expat \
    file \
    getopt \
    gettext \
    gmake \
    gnutls \
    htop \
    httperf \
    iftop \
    iperf \
    ipython_select \
    libxml2 \
    libxslt \
    libyaml \
    lzo2 \
    m4 \
    makepasswd \
    maven3 \
    maven_select \
    mc \
    mcrypt \
    memtester \
    mercurial \
    ncurses \
    netcat \
    nginx \
    nmap \
    nodejs \
    nosetests_select \
    npm \
    openssl \
    p7zip \
    pcre \
    popt \
    python26 \
    py26-docutils \
    py26-gobject \
    py26-lxml \
    py26-nose \
    py26-openssl \
    py26-pip \
    py26-setuptools \
    py26-virtualenv \
    py26-virtualenv-clone \
    py26-virtualenvwrapper \
    python27 \
    py27-bpython \
    py27-ipython \
    py27-libxml2 \
    py27-nose \
    py27-numpy \
    py27-pip \
    py27-pygments \
    py27-readline \
    py27-setuptools \
    py27-virtualenv \
    py27-virtualenv-clone \
    py27-virtualenvwrapper \
    python32 \
    py32-lxml \
    py32-pip \
    py32-setuptools \
    py32-virtualenv \
    python33 \
    py33-pip \
    py33-setuptools \
    py33-virtualenv \
    pypy \
    python_select \
    readline \
    rsync \
    sqlite3 \
    subversion \
    terminal-notifier \
    tig \
    virtualenv_select \
    watch \
    wget \
    xz \
    zlib \
    zmq \
    zsh
    # faac \
    # ffmpeg \
    # lame \
    # mysql55 \
    # mysql55-server \
    # mysql_select \
    # postgresql92 \
    # postgresql92-server \
    # postgresql_select \
