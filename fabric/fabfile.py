# _*_ coding: utf-8 _*_
# Copyright (c) Nikita Kovaliov, maizy.ru, 2013
from __future__ import unicode_literals, print_function, absolute_import
import sys
from os import path

from fabric.api import env


def init(env):
    if hasattr(env, 'POSSIBLE_KEYS') and env.POSSIBLE_KEYS:
        ssh_dir = path.abspath(path.expanduser('~/.ssh'))
        if isinstance(env.key_filename, (list, tuple)):
            keys = list(env.key_filename)
        elif env.key_filename is not None:
            keys = [env.key_filename]
        else:
            keys = []

        for key in env.POSSIBLE_KEYS:
            key_path = path.join(ssh_dir, key)
            if path.isfile(key_path):
                keys.append(key_path)
        env.key_filename = keys

try:
    import hh_kovalev.fabric as hh_fabric
    hh = True
except ImportError:
    hh = False

# settings
env.ROOT_DIR = path.abspath(path.dirname(__file__))
env.PEP8_LIST_DIR = path.abspath(path.expanduser('~/Documents/Pep8_lists'))
env.GIT_PRESERVE_BRANCHES = ['master', 'release-candidate']
env.POSSIBLE_KEYS = []
env.use_ssh_config = True
env.forward_agent = True
env.disable_known_hosts = True  # workarond for veeeery slow ssh connection in OS X
if env.ROOT_DIR not in sys.path:
    sys.path.append(env.ROOT_DIR)

# init
init(env)

if hh:
    hh_fabric.init_env()
    del hh_fabric
    from hh_kovalev.fabric.exports import *

from maizy_f import netstat, git, service, fs, r
from maizy_f.root import *
