# _*_ coding: utf-8 _*_
# anonymize github organization reps json (for hedgehog stubs)

import sys
import json
import random

_chars = [unichr(i) for i in xrange(ord(u'a'), ord(u'z'))]


def rand_word():
    wlen = random.randint(5, 40)
    return u''.join(random.choice(_chars) for i in xrange(wlen))


def rep_rec(data, needle, replace):
    for k, v in data.items():
        if isinstance(v, dict):
            rep_rec(v, needle, replace)
        elif isinstance(v, unicode) and needle in v:
            data[k] = v.replace(needle, replace)

if __name__ == '__main__':
    assert len(sys.argv) > 1
    f = sys.argv[1]
    data = json.load(open(f), encoding='utf-8')
    for repo in data:
        if repo['private']:
            name = rand_word()
            old_name = repo['name']
            print '{} => {}'.format(old_name, name)
            rep_rec(repo, old_name, name)
            repo['description'] = ' '.join(rand_word() for i in xrange(random.randint(1, 10)))

            if 'homepage' in repo:
                repo['homepage'] = 'http://example.com/' + name
    processed = open(f+'.processed', 'w')
    res = json.dumps(data, ensure_ascii=False, encoding=unicode, indent=4)
    processed.write(res.encode('utf-8'))
