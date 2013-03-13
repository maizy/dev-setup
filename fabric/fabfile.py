# _*_ coding: utf-8 _*_
# Copyright (c) Nikita Kovaliov, maizy.ru, 2013
from __future__ import unicode_literals, print_function

import sys
from os import path
import os

from fabric.api import local, env, lcd, task, settings

try:
    import hh_kovalev.fabric as hh_fabric
    hh = True
except ImportError:
    hh = False

env.ROOT_DIR = path.abspath(path.dirname(__file__))
env.PEP8_LIST_DIR = path.abspath(path.expanduser('~/Documents/Pep8_lists'))

if env.ROOT_DIR not in sys.path:
    sys.path.append(env.ROOT_DIR)

if hh:
    hh_fabric.init_env()
    from hh_kovalev.fabric.exports import *

import netstat, service

@task
def pep8(*paths):
    with settings(warn_only=True):
        if not paths:
            paths = ['./']
        local('pep8 --repeat --show-source --statistics --ignore=E501 ' + ' '.join(paths))

@task
def pep8l(conf_file):
    lines = open(path.join(env.PEP8_LIST_DIR, conf_file)).readlines()
    cwd = os.getcwd()
    for line in lines:
        line = line.rstrip()
        if line[0] == '#':
            cwd = line[1:]
            continue
        with lcd(cwd):
            pep8(line)
