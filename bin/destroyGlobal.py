#!/usr/bin/env python

from lsst.cat.MySQLBase import MySQLBase
from lsst.cat.policyReader import PolicyReader

import getpass
import optparse
import os
import sys


usage = """%prog -f policyFile

Destroys the Global Database and the data-challange specific database.
"""

parser = optparse.OptionParser(usage)
parser.add_option("-f")

options, arguments = parser.parse_args()
if not options.f:
    sys.stderr.write(os.path.basename(sys.argv[0]) + usage[5:])
    sys.exit(1)


r = PolicyReader(None, options.f)
(serverHost, serverPort) = r.readAuthInfo()
(globalDbName, dcVersion, dummy1, dummy2) = r.readGlobalSetup()
dcDb = '%s_DB' % dcVersion


print """
   ** WARNING **
   You are attempting to destroy the '%s' database 
   and the '%s' database - think twice before proceeding!
""" % (globalDbName, dcDb)


dbSUName = raw_input("Enter mysql superuser account name: ")
dbSUPwd = getpass.getpass()

dcDbName = '%s_DB' % dcVersion

def destroyOne(x, dbName):
    if x.dbExists(dbName):
        x.execCommand0("DROP DATABASE IF EXISTS " + dbName)
        print "Destroyed '%s'." % dbName
    else:
        print "Db '%s' does not exist." % dbName

x = MySQLBase(serverHost, serverPort)
x.connect(dbSUName, dbSUPwd)
destroyOne(x, globalDbName)
destroyOne(x, dcDbName)
x.disconnect()
