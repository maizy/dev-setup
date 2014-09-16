# _*_ coding: utf-8 _*_
# Copyright (c) Nikita Kovaliov, maizy.ru, 2013
from __future__ import print_function, absolute_import, unicode_literals

import os
import sys
import re
import curses.ascii
import random
import time
from functools import partial
from collections import defaultdict

from fabric.api import task, prompt, local
from fabric.colors import magenta, yellow, red

from maizy_f import to_unicode

note = partial(magenta, bold=True)
warn = partial(red, bold=True)
title = partial(yellow, bold=True)


@task
def rand_rename(path='.'):
    rpath = os.path.realpath(path)
    files = [f for f in os.listdir(rpath) if not f.startswith('.')]
    print('Are you sure to randomize {n} files in {path} ?'.format(path=rpath, n=len(files)))
    if not prompt('[N/y]') in ('y', 'Y'):
        print('Aborted by user', file=sys.stderr)
        return False

    random.shuffle(files)
    name_len = len(str(len(files) + 1))

    tmp_dir = os.path.join(rpath, '.tmp_{}'.format(time.time()))
    os.mkdir(tmp_dir)
    map(lambda x: os.rename(os.path.join(rpath, x), os.path.join(tmp_dir, x)), files)

    for n, orig_name in enumerate(files, start=1):
        ext = os.path.splitext(orig_name)[1].lower()
        new_name = str(n).rjust(name_len, b'0') + ext
        new_path = os.path.join(rpath, new_name)
        print('{} => {}'.format(orig_name, new_name))
        if os.path.exists(new_path):
            print('Oops. File {} ever exists in {}.'.format(new_name, rpath), file=sys.stderr)
            return False
        os.rename(os.path.join(tmp_dir, orig_name), os.path.join(rpath, new_name))
    os.rmdir(tmp_dir)
    print('OK')
    return True


@task
def unzip_all(source_dir='.', dest_dir='.'):
    files = sorted([f for f in os.listdir(source_dir) if f.endswith('.zip')])
    for i, zip_file in enumerate(files, start=1):
        res_dir = os.path.join(dest_dir, zip_file[:-len('.zip')])
        print(note('{i:2d}/{t:2d} {f} => {r}'.format(i=i, t=len(files), f=zip_file, r=res_dir)))
        if os.path.exists(res_dir):
            print('Skip, unzipped before')
            continue
        zip_path = os.path.join(source_dir, zip_file)
        os.makedirs(res_dir, mode=0755)
        local('unzip {f} -d {d}'.format(f=zip_path, d=res_dir))


# TODO:
#     * more infomative output
#     * additional check by some hash alg
@task
def find_duplicates(origs, matches=None):
    if matches is None:
        matches = origs
    origs = to_unicode(origs)
    matches = to_unicode(matches)

    report = defaultdict(lambda: {'origs': [], 'matched': []})
    files_orig = 0

    for root, _, files in os.walk(origs):
        for orig_file in files:
            orig_path = os.path.join(root, orig_file)
            if not os.path.isfile(orig_path):
                continue
            files_orig += 1
            size = os.path.getsize(orig_path)
            report[size]['origs'].append(orig_path)

    for root, _, files in os.walk(matches):
        for match_file in files:
            match_path = os.path.join(root, match_file)
            if not os.path.isfile(match_path):
                continue
            match_size = os.path.getsize(match_path)
            if match_size in report.keys() and match_path not in report[match_size]['origs']:
                report[match_size]['matched'].append(match_path)

    report = [(size, group) for size, group in report.iteritems() if len(group['matched']) > 0]
    report.sort(key=lambda p: p[1]['origs'][0])

    for size, group in report:
        print(title(', '.join(group['origs'])) + ' ({} bytes)'.format(size))
        print('\n'.join(group['matched']))
        print()

    files_matched = reduce(lambda acc, p: acc + len(p[1]['origs']), report, 0)
    print(note('Statistics'))
    print(
        '\tOrig: {o} files\n'
        '\tMatched: {m} files in {mg} groups\n'
        '\tNot matched: {n} files\n'.format(o=files_orig, m=files_matched, n=files_orig - files_matched,
                                            mg=len(report))
    )


@task
def check_control_chars(path):
    path = os.path.expanduser(path)
    if not os.path.exists(path):
        print(warn('Path not exists: ') + ' ' + path)
        return False
    content = open(path, 'rb').read()
    line = 0
    char_pos = 0
    index = {getattr(curses.ascii, readable_name): readable_name for readable_name in curses.ascii.controlnames}
    for c in content:
        if curses.ascii.iscntrl(c) or c == chr(curses.ascii.DEL):
            print('Control char or DEL at {line}:{pos} => "0x{c:02x}" ({c} - {readable})'
                  .format(c=ord(c), line=line, pos=char_pos, readable=index.get(ord(c), '? UNKNOWN')))
        if c == b'\n':
            line += 1
        char_pos += 1
