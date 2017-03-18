#!/usr/bin/env python3.3
# _*_ coding: utf-8 _*_
# Copyright (c) Nikita Kovaliov, maizy.ru, 2013

# Tested only in OS X 10.8
# Python 3.3 required

# usage:
#   bzgrep 'any string your want' /var/log/system.log.*.bz2 | syslog_analizer

import sys
import re
from datetime import datetime
import collections

_syslog_line_regexp = re.compile(
    r'''
        (?P<filename>[^:]*)
        :*
        (?P<mon>[a-z]{2,4})
        \s+
        (?P<day>[0-9]{1,2})
        \s+
        (?P<time>[0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2})
        (?P<etc>.*)
    ''',
    re.VERBOSE | re.IGNORECASE)


def analize(stream):
    counts_time = collections.Counter()
    counts_minute = collections.Counter()

    for n, line in enumerate(stream):
        #sys.stdout.write('.')
        #sys.stdout.flush()
        res = _syslog_line_regexp.match(line)
        if not res:
            print('wrong line {}: {}'.format(n, line))
            continue
        date_s = '{day} {mon} {time}'.format(**res.groupdict())
        date = datetime.strptime(date_s, '%d %b %H:%M:%S')
        date = date.replace(year=datetime.now().year)

        key = date.strftime('%Y-%m-%d %H:%M')
        key2 = date.minute

        counts_time[key] += 1
        counts_minute[key2] += 1

    print('counts_time:')
    print('\n'.join(('{}: {}'.format(*x) for x in counts_time.most_common(20))))

    print('counts_minute:')
    print('\n'.join(('{}: {}'.format(*x) for x in counts_minute.most_common())))


if __name__ == '__main__':
    analize(sys.stdin)
