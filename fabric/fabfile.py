# _*_ coding: utf-8 _*_
# Copyright (c) Nikita Kovaliov, maizy.ru, 2013
from __future__ import unicode_literals, print_function, absolute_import
import sys
from os import path

from fabric.api import env

try:
    import hh_kovalev.fabric as hh_fabric
    hh = True
except ImportError:
    hh = False

# settings
env.ROOT_DIR = path.abspath(path.dirname(__file__))
env.PEP8_LIST_DIR = path.abspath(path.expanduser('~/Documents/Pep8_lists'))
env.GIT_PRESERVE_BRANCHES = ['master', 'release-candidate']
if env.ROOT_DIR not in sys.path:
    sys.path.append(env.ROOT_DIR)

if hh:
    hh_fabric.init_env()
    del hh_fabric
    from hh_kovalev.fabric.exports import *

from maizy_f import netstat, git, service
from maizy_f.root import *
