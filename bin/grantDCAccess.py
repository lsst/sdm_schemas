#!/usr/bin/env python

from lsst.cat.MySQLBase import MySQLBase
from lsst.cat.policyReader import PolicyReader

import getpass
import optparse
import os
import re
import sys

"""
    This script grants appropriate data-challenge-specific privileges for
    all users except these that already have super-user grant and "test"
"""


usage = """%prog [-f {policyFile}] [-c {clientHost}]
Where:
  - clientHost:      host names authorized to access mysql server,
                     wildcards are allowed. Default: "%" (all hosts)
  - policyFile:      policy file. Default $CAT_DIR/policy/defaultProdCatPolicy.paf
"""


parser = optparse.OptionParser(usage)
parser.add_option("-f")
parser.add_option("-c")

options, arguments = parser.parse_args()

if options.c:
    clientHost = options.c
else:
    clientHost = '%'

r = PolicyReader(options.f)
(serverHost, serverPort) = r.readAuthInfo()
(globalDbName, dcVersion, dcDb, dummy1, dummy2) = r.readGlobalSetup()

rootU = raw_input("Enter mysql superuser account name: ")
rootP = getpass.getpass()

admin = MySQLBase(serverHost, serverPort)
admin.connect(rootU, rootP, globalDbName)

grantAll = re.compile('GRANT ALL PRIVILEGES ON \*.\* TO')

users = admin.execCommandN('SELECT user from mysql.user WHERE user != "root" AND user != "sysbench"' AND user != 'test')
for u in users:
    grants = admin.execCommandN("SHOW GRANTS FOR '%s'" % u)
    isSU = 0
    for g in grants:
        if grantAll.match(g[0]):
            isSU = 1
    if isSU:
        print "Skipping superuser ", u[0]
    else:
        toStr = "TO `%s`@`%s`" % (u[0], clientHost)
        cmd = "GRANT SELECT, INSERT ON `%s\_DB`.* %s" % (dcVersion, toStr)
        admin.execCommand0(cmd)
        print "Executed command: ", cmd
