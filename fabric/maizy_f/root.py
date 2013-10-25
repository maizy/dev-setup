# _*_ coding: utf-8 _*_
# Copyright (c) Nikita Kovaliov, maizy.ru, 2013
from __future__ import print_function, absolute_import, unicode_literals

import os
from os import path

from fabric.api import task, settings, env, local, lcd


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