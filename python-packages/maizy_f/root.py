# coding: utf-8
# Copyright (c) Nikita Kovaliov, maizy.ru, 2013-2014
from __future__ import print_function, absolute_import, unicode_literals

import os
from os import path
import socket
import random
import urllib2
import re

from fabric.api import task, settings, env, local, lcd, hide

from maizy_f import print_title, print_note


@task
def pep8(*paths):
    with settings(warn_only=True):
        if not paths:
            paths = ['./']
        local('pep8 --repeat --show-source --statistics --max-line-length=120 ' + ' '.join(paths))


@task
def pep8l(*args):
    conf_file = args[0] if len(args) > 0 else None
    if conf_file is None or conf_file == '?':
        print('Avalable lists:\n * {0}'.format('\n * '.join(os.listdir(env.PEP8_LIST_DIR))))
        return

    lines = open(path.join(env.PEP8_LIST_DIR, conf_file)).readlines()
    cwd = os.getcwd()
    for line in lines:
        line = line.rstrip()
        if len(line) == 0:
            continue
        if line[0] == '#':
            cwd = line[1:]
            print('cd {0}'.format(cwd))
            continue
        with lcd(cwd):
            pep8(line)


@task
def env_info():
    print('Enabled extenders: {}'.format(','.join(env.ENABLED_EXTENDERS)))
    print()
    print('Env settings:\n * {}'.format('\n * '.join(
        '{}={}'.format(k, repr(env[k])) for k in sorted(env.keys()) if k
    )))


@task
def resolve(domain):
    print_title('system resolve (hosts, dns ...)')
    try:
        print(socket.gethostbyname(domain))
    except socket.error as e:
        print('Unable to resolve {d}: {ec.__name__}: {e}'.format(ec=e.__class__, e=e, d=domain))
    print()

    print_title('dns resolve (nslookup)')
    local('nslookup {}'.format(domain))


@task
def randtext(only_text=False):
    #
    #               ж: )
    #
    base_url = b'aHR0cHM6Ly9yZWZlcmF0cy55YW5kZXgucnUvcmVmZXJhdHMvd3JpdGUv\n'.decode('base64')
    themes = [b'YXN0cm9ub215\n', b'Z2VvbG9neQ==\n', b'Z3lyb3Njb3Bl\n', b'bGl0ZXJhdHVyZQ==\n', b'bWFya2V0aW5n\n',
              b'bWF0aGVtYXRpY3M=\n', b'bXVzaWM=\n', b'cG9saXQ=\n', b'YWdyb2Jpb2xvZ2lh\n', b'bGF3\n',
              b'cHN5Y2hvbG9neQ==\n', b'Z2VvZ3JhcGh5\n', b'cGh5c2ljcw==\n', b'cGhpbG9zb3BoeQ==\n', b'Y2hlbWlzdHJ5\n',
              b'ZXN0ZXRpY2E=\n']

    themes = [s.decode('base64') for s in themes]

    selected_themes = themes[:]
    random.shuffle(selected_themes)
    selected_themes = selected_themes[0:random.randint(1, len(themes))]

    url = b'{base}?t={themes}'.format(base=base_url, themes=b'+'.join(selected_themes))
    res = urllib2.urlopen(url).read()

    def get_parts(tag):
        matches = re.findall(br'<%s>([^<]+?)</%s>' % (tag, tag), res, re.MULTILINE)
        if matches:
            return [s.decode('utf-8') for s in matches]
        return []

    object_ = get_parts('div')[-1]
    title = get_parts('strong')[-1]
    paragraphs = '\n\n'.join(get_parts('p'))
    if only_text:
        text = paragraphs
    else:
        text = '{o}\n{t}\n\n{p}'.format(o=object_.upper(), t=title, p=paragraphs)

    print_title('Random text generated')
    print(text)
    with settings(hide('warnings', 'stdout', 'running'), warn_only=True):
        local('echo "{}" | pbcopy'.format(text))
    print('')
    print_note('text copied to clipboard')
