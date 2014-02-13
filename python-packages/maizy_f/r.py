# _*_ coding: utf-8 _*_
# Copyright (c) Nikita Kovaliov, maizy.ru, 2013
from __future__ import print_function, absolute_import, unicode_literals


from fabric.api import task, run


@task
def info():
    run('uname -a')
    run('hostname')
    lsb_rel = run('which lsb_release')
    if lsb_rel != '':
        print('Debian like os found')
        run('lsb_release -a')
