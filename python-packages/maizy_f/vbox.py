# _*_ coding: utf-8 _*_
from functools import partial

from fabric.api import local, task


def create(box_id):
    actions = _create_with_params(add_task=False)
    return _append_to_tasks({key: partial(func, box_id=box_id) for key, func in actions.iteritems()})


def _create_with_params(add_task=True):
    def start(box_id, gui=False):
        local('VBoxManage startvm {vm} --type {type}'.format(vm=box_id, type='gui' if gui else 'headless'))

    def stop(box_id):
        local('VBoxManage controlvm {vm} acpipowerbutton'.format(vm=box_id))

    def status(box_id):
        local("VBoxManage showvminfo {vm} | grep 'State:'".format(vm=box_id))

    actions = {
        'start': start,
        'stop': stop,
        'status': status
    }

    return _append_to_tasks(actions) if add_task else actions


def _append_to_tasks(actions):
    return {key: task(func) for key, func in actions.iteritems()}

start, stop, status = _create_with_params(add_task=True).values()
