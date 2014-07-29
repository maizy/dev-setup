# _*_ coding: utf-8 _*_
import sys
from functools import partial


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
