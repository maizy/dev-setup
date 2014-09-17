# coding: utf-8
# Copyright (c) Nikita Kovaliov, maizy.ru, 2013-2014
from __future__ import unicode_literals, print_function, absolute_import
import os
import sys
import importlib

from fabric.api import env

EXTENDERS = ['maizy_f', 'hh_kovalev.fabric', 'smaizy.fabric'] + filter(None, os.getenv('F_EXTENDERS', '').split(','))
_ENABLED_EXTENDERS = {}
for module in EXTENDERS:
    try:
        _ENABLED_EXTENDERS[module] = importlib.import_module(module)
    except ImportError:
        pass

# settings
env.DEV_ROOT = os.path.expanduser('~/Dev')
env.ENABLED_EXTENDERS = _ENABLED_EXTENDERS.keys()

# fabric settings
env.use_ssh_config = True
env.forward_agent = True
env.disable_known_hosts = True  # workarond for veeeery slow ssh connection in OS X


def load_extenders(extenders):
    task_modules = {}
    for name, module in extenders.iteritems():
        if hasattr(module, 'init_env') and callable(module.init_env):
            try:
                module.init_env(env)
            except Exception as e:
                sys.stderr.write('Errors on init {name}. WARN: state may be inconsistent!\n{e.__class__}: {e}\n'
                                 .format(name=name, e=e))
                continue

        # load exports - black magic :)
        try:
            exports = importlib.import_module('{}.exports'.format(name))
        except ImportError as e:
            sys.stderr.write('Unable to import {}.exports: {}\n'.format(name, e))
            continue
        task_modules.update({i: getattr(exports, i) for i in dir(exports) if not i.startswith('_')})
    return task_modules

locals().update(load_extenders(_ENABLED_EXTENDERS))

# load local conf
local_conf = os.path.expanduser('~/.config/f.py')
if os.path.isfile(local_conf):
    execfile(local_conf, {}, {'__file__': local_conf, 'env': env})
