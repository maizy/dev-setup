# _*_ coding: utf-8 _*_
from functools import partial


def to_unicode(val):
    if isinstance(val, str):
        return val.decode('utf-8')
    if not type(val) == unicode:
        return unicode(val)  # strip pseudo unicode types
    return val


def partial_with_doc(func, _doc='', *args, **kwargs):
    partial_func = partial(func, *args, **kwargs)
    partial_func.__doc__ = _doc
    return partial_func
