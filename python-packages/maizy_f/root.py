# coding: utf-8
# Copyright (c) Nikita Kovaliov, maizy.ru, 2013-2014
from __future__ import print_function, absolute_import, unicode_literals

import os
from os import path
import socket

from fabric.api import task, settings, env, local, lcd

from maizy_f import print_title
from maizy_f.ssh_tunnel import ssh_tunnel


@task
def pep8(*paths):
    with settings(warn_only=True):
        if not paths:
            paths = ['./']
        local('pep8 --repeat --show-source --statistics --max-line-length=120 ' + ' '.join(paths))


@task
def pep8l(*args):
    conf_file = args[0] if len(args) > 0 else None
    if conf_file is None or conf_file == '?':
        print('Avalable lists:\n * {0}'.format('\n * '.join(os.listdir(env.PEP8_LIST_DIR))))
        return

    lines = open(path.join(env.PEP8_LIST_DIR, conf_file)).readlines()
    cwd = os.getcwd()
    for line in lines:
        line = line.rstrip()
        if len(line) == 0:
            continue
        if line[0] == '#':
            cwd = line[1:]
            print('cd {0}'.format(cwd))
            continue
        with lcd(cwd):
            pep8(line)


@task
def env_info():
    print('Enabled extenders: {}'.format(','.join(env.ENABLED_EXTENDERS)))
    print()
    print('Env settings:\n * {}'.format('\n * '.join(
        '{}={}'.format(k, repr(env[k])) for k in sorted(env.keys()) if k
    )))


@task
def resolve(domain):
    print_title('system resolve (hosts, dns ...)')
    try:
        print(socket.gethostbyname(domain))
    except socket.error as e:
        print('Unable to resolve {d}: {ec.__name__}: {e}'.format(ec=e.__class__, e=e, d=domain))
    print()

    print_title('dns resolve (nslookup)')
    local('nslookup {}'.format(domain))
