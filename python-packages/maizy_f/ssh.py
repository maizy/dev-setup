# coding: utf-8
# Copyright (c) Nikita Kovaliov, maizy.ru, 2015

from __future__ import print_function, unicode_literals
import socket
import re
import os

from fabric.api import task, local, settings, hide
from fabric.colors import yellow, blue, red

from maizy_f import print_title, natural_sort


def is_local_port_available(port):
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.bind((b'', port))
        sock.close()
        available = True
    except socket.error:
        available = False
    return available


@task
def tunnel(ssh_proxy_host, remote_host_and_port, local_port):

    if remote_host_and_port.count(':') != 1:
        print("remote_host_and_port should be in format 'HOST:PORT'")
        return 1
    remote_host, remote_port = remote_host_and_port.split(':')

    if not re.match(r'[1-9]+[0-9]*', local_port) or not is_local_port_available(int(local_port)):
        print(red("Local port {} is used by another process".format(local_port)))
        return 1

    ssh_map = "{}:{}:{}".format(local_port, remote_host, remote_port)
    cmd = 'ssh -N -C -c blowfish -f -L {} {}'.format(ssh_map, ssh_proxy_host)

    def get_pid():
        with settings(hide('warnings', 'stdout', 'running'), warn_only=True):
            return local('pgrep -f {}'.format(ssh_map), capture=True)
    tunnel_pid = get_pid()

    create = True
    if tunnel_pid:
        create = False
        print("Tunnel ever exists, create new? [y/N]")
        if raw_input() not in ('y', 'Y'):
            create = True

    if create:
        local(cmd)
        print_title('SSH tunnel CREATED')
        tunnel_pid = get_pid()
    else:
        print_title('EXISTING SSH tunnel')

    print('Map: {}'.format(ssh_map))
    print('Web Link: {}'.format(blue('http://127.0.0.1:{}/'.format(local_port))))
    print('Possible PID: {}'.format(tunnel_pid))
    print(yellow('kill {}'.format(tunnel_pid)))


@task
def aliases():
    aliases = []
    with open(os.path.expanduser('~/.ssh/config'), 'rb') as f:
        for line in f:
            stripped = line.strip()
            if stripped.startswith('Host '):
                aliases.append(stripped[len('Host '):].strip())
    aliases = natural_sort(aliases)
    print_title('SSH aliases')
    print('\n'.join(aliases))
