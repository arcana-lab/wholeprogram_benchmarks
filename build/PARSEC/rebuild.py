#!/bin/python

import os
import sys


makeAll = 1

args = []

for arg in sys.argv[1:]:
    if arg == "all":
        makeAll = 1
        break
    else:
        makeAll = 0
        args.append(arg)

if "download" in args or makeAll:
    os.system("./scripts/download.sh")

if "setup" in args or makeAll:
    os.system("./scripts/setup.sh")

if "compile" in args or makeAll:
    os.system("./scripts/compile.py all")

if "clean" in args:
    os.system("./scripts/uninstall.sh")


