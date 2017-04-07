#!/usr/bin/env python

import os
import sys

W = os.path.abspath(os.path.dirname(os.path.dirname(__file__)))
readme = open('docs/usage.md').read()

content = open('hacking/ms_iptables.py.in').read()

with open('ms_iptables.py', 'w') as fic:
    fic.write(content.replace('__USAGE__', readme))
os.chmod('ms_iptables.py', 0o755)
# vim:set et sts=4 ts=4 tw=80:
