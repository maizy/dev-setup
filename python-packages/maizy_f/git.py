# _*_ coding: utf-8 _*_
# Copyright (c) Nikita Kovaliov, maizy.ru, 2013
from __future__ import print_function, absolute_import, unicode_literals

from fabric.api import local, task, env, prompt


@task
def rm_merged(branch=None):
    preserver_branches = getattr(env, 'GIT_PRESERVE_BRANCHES', [])
    current_branch = local('git rev-parse --abbrev-ref HEAD', capture=True).strip()
    if len(current_branch) == 0:
        print('Current branch not detected, possibly you are not in a git repo')
        return False
    print('Current branch: {0}'.format(current_branch))
    if branch is None:
        branch = current_branch
    out = local('git branch --merged {0}'.format(branch), capture=True)
    to_del = []
    for line in out.split('\n'):
        line = line.strip(' *\t')
        if len(line) == 0:
            continue
        if line == current_branch:
            print("Skip branch {0}, because it's current branch".format(line))
            continue
        if line == branch:
            print("Skip branch {0}".format(line))
            continue
        if line in preserver_branches:
            print("Skip branch {0}, because it's in preserve branches list".format(line))
            continue
        to_del.append(line)
    if len(to_del) == 0:
        print('Nothing to delete')
        return False
    div = '\n   * '
    print('Are you sure to delete those branches:{div}{branches}'
          .format(branches=div.join(to_del), div=div))
    res = prompt('[N/y]')
    if res in ('Y', 'y', 'н', 'Н'):
        for br in to_del:
            local('git branch -D {0}'.format(br))
        return True
    else:
        print('Canceled')
        return False


@task
def cip(all='true'):
    all = all.lower() in ('true', '1', 't', 'y')
    local('git commit' + (' --all' if all else ''))
    local('git push')
