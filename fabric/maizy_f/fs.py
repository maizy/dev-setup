# _*_ coding: utf-8 _*_
# Copyright (c) Nikita Kovaliov, maizy.ru, 2013
from __future__ import print_function, absolute_import, unicode_literals

import os
import sys
import random
import time
from functools import partial

from fabric.api import task, prompt, local
from fabric.colors import magenta
note = partial(magenta, bold=True)


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
