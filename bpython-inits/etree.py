# _*_ coding: utf-8 _*_
# Copyright (c) Nikita Kovaliov, HeadHunter.ru, 2013

from lxml import etree

def p(elem):
    print(etree.tostring(elem, pretty_print=True))

a = etree.Element('a')
b = etree.Element('b', prop='123', tprop='abc')
b2 = etree.Element('b', prop='456', tprop='def')
c = etree.Element('c')

a.insert(0, b)
a.insert(1, b2)
b.insert(0, c)

t = a.getroottree()

print ('add t + a, b, b2, c\n\na:')
p(t)
