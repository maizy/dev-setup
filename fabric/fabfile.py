# _*_ coding: utf-8 _*_
# Copyright (c) Nikita Kovaliov, maizy.ru, 2013

import sys
from os import path

from fabric.api import local, env, lcd

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
    import hh_kovalev.fabric.dev as hh_dev

import netstat, service
