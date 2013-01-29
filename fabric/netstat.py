# _*_ coding: utf-8 _*_
# Copyright (c) Nikita Kovaliov, maizy.ru, 2013

from fabric.api import task, local, env

@task
def tcp():
    local('lsof -i TCP -P | grep -i listen')
