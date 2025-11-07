# coding: utf-8
# Copyright (c) Nikita Kovaliov, maizy.ru, 2018
from __future__ import print_function, absolute_import, unicode_literals

import json

from fabric.api import task, local, settings, hide
import humanize


@task
def s3du(path, profile=None):
    assert(path.startswith("s3://"))

    parts = path.split('/')
    assert(len(parts) >= 3)  # [s3:] / [] / [bucket] / [path] ...
    bucket = parts[2]
    prefix_parts = parts[3:]

    prefixes_to_summarize = []

    if prefix_parts and prefix_parts[-1] == '*':
        with settings(hide('warnings', 'stdout'), warn_only=True):
            base_prefix = '/'.join(prefix_parts[:-1] + [''])
            cmd = ['aws', 's3', 'ls', 's3://{b}/{c}'.format(b=bucket, c=base_prefix)]
            if profile is not None:
                cmd.extend(['--profile', profile])
            raw = local(' '.join(cmd), capture=True)
        for line in raw.split('\n'):
            line = line.strip()
            if line.startswith('PRE '):
                prefix = line[len('PRE '):]
                prefixes_to_summarize.append(base_prefix + prefix)
    else:
        prefixes_to_summarize.append('/'.join(parts[3:]))

    base_cmd = [
        'aws', 's3api', 'list-objects',
        '--bucket', bucket,
        '--output', 'json',
        '--query', "'[sum(Contents[].Size), length(Contents[])]'"]
    if profile is not None:
        base_cmd.extend(['--profile', profile])

    print("Calculate size for:\n  * {}\n\n".format('\n  * '.join(prefixes_to_summarize)))

    for prefix in prefixes_to_summarize:
        print("s3://{b}/{p}".format(b=bucket, p=prefix))
        cmd = base_cmd[:]
        if prefix:
            cmd.extend(['--prefix', prefix])

        with settings(hide('warnings', 'stdout', 'running'), warn_only=True):
            raw = local(' '.join(cmd), capture=True)
            try:
                result = json.loads(raw)
                total_size, amount = result
                print("Total size: {f} ({s})".format(f=humanize.naturalsize(total_size, binary=True), s=total_size))
                print("Files: {}".format(amount))
            except ValueError as e:
                print("Error: {}".format(e))
            print()
