# _*_ coding: utf-8 _*_


def to_unicode(val):
    if isinstance(val, str):
        return val.decode('utf-8')
    if not type(val) == unicode:
        return unicode(val)  # strip pseudo unicode types
    return val
