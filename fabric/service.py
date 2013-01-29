# _*_ coding: utf-8 _*_
# Copyright (c) Nikita Kovaliov, HeadHunter.ru, 2013

from fabric.api import local, env, task


@task
def start(service):
    local('sudo port load {}'.format(service))


@task
def stop(service):
    local('sudo port unload {}'.format(service))


@task
def restart(service):
    stop(service)
    start(service)
