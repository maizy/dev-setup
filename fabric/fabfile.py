# _*_ coding: utf-8 _*_
# Copyright (c) Nikita Kovaliov, maizy.ru, 2013

import sys
from os import path

from fabric.api import local, env, lcd, task, settings

try:
    import hh_kovalev.fabric as hh_fabric
    hh = True
except ImportError:
    hh = False

env.ROOT_DIR = path.abspath(path.dirname(__file__))

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