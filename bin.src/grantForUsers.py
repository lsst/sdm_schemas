#!/usr/bin/env python

from lsst.cat.MySQLBase import MySQLBase
from lsst.cat.policyReader import PolicyReader

import getpass
import optparse
import os
import sys

"""
   This script runs a command specified below for all users
   except these that already have super-user grant
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


def showGrantsForAllUsers():
    users = admin.execCommandN('SELECT user from mysql.user')
    for u in users:
        grants = admin.execCommandN("SHOW GRANTS FOR '%s'" % u)
        print 'grants for user %s ' %u
        for g in grants:
            print '   ', g


users = admin.execCommandN('SELECT DISTINCT(user) FROM mysql.tables_priv')
for u in users:
    toStr = "TO `%s`@`%%`" % u
    # admin.execCommand0("GRANT ALL ON `%s\_%%`.* %s" % (userName, toStr))

    for ff in ["angSepArcsec",
               "dnToAbMag",
               "dnToAbMagSigma",
               "dnToFlux",
               "dnToFluxSigma",
               "fluxToAbMag",
               "fluxToAbMagSigma",
               "mjdTaiToTai",
               "mjdUtcToTai",
               "taiToMjdTai",
               "taiToMjdUtc",
               "taiToUtc",
               "utcToTai"]:
        cmd = "GRANT EXECUTE ON FUNCTION `rplante_DC3b_u_pt11final`.`%s` %s" % (ff, toStr)
        print(cmd)
        #admin.execCommand0(cmd)



