# coding: utf-8
# Copyright (c) Nikita Kovaliov, maizy.ru, 2013
from __future__ import print_function, absolute_import, unicode_literals

from fabric.api import task, local


@task
def tcp():
    local('sudo lsof -i TCP -P | grep -i listen')
