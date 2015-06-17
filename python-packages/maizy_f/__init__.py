# coding: utf-8
from __future__ import print_function, unicode_literals

import sys
import os
from functools import partial
import re

from fabric.colors import magenta, yellow


def to_unicode(val):
    if isinstance(val, str):
        return val.decode('utf-8')
    if not type(val) == unicode:
        return unicode(val)  # strip pseudo unicode types
    return val


def to_str(val):
    if isinstance(val, unicode):
        return val.encode('utf-8')
    if not type(val) == str:
        return str(val)  # strip pseudo str types
    return val


def partial_with_doc(func, _doc='', *args, **kwargs):
    partial_func = partial(func, *args, **kwargs)
    partial_func.__doc__ = _doc
    return partial_func


def set_terminal_title(title):
    sys.stdout.write('\x1b]2;{}\x07'.format(to_str(title)))


def init_env(env):
    env.PEP8_LIST_DIR = os.path.abspath(os.path.expanduser('~/Documents/Pep8_lists'))
    env.GIT_PRESERVE_BRANCHES = ['master', 'release-candidate']


def print_title(text):
    print(yellow(text, bold=True))


def print_note(text):
    print(magenta(text))


def natural_sort(seq):
    convert = lambda text: int(text) if text.isdigit() else text.lower()
    alphanum_key = lambda key: [convert(c) for c in re.split(br'([0-9]+)', key)]
    return sorted(seq, key=alphanum_key)
