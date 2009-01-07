#!/usr/bin/env python

from mysqlBase import MySQLBase
import optparse
import os
import sys

"""
   This script adds mysql user, including setting up all needed 
   authorizations to run DCx runs.
   User will be able to start runs, and extend runs' expiration time.
   Notice that users won't be able to hack in and extend runs by calling 
   'UPDATE' by hand
"""


usage = """%prog -f {policyFile} -s {mysqlServerHost} -u {userName} -p {userPassword} -e {userEmail} -c {clientHost} -g {globalDbName} -v {dcVersion}
Where:
  - policyFile:      the policy file containing mysql superuser name and password.
  - mysqlServerHost: host name where the mysql server runs
  - userName:        mysql username of the added user
  - userPassword:    mysql password of the added user
  - userEmail:       email address of the added user
  - clientHost:      host name where user will jobs, wildcards allowed
  - globalDbName:    name of the mysql "global database"
  - dcVersion:       DC version, eg DC3a
"""


parser = optparse.OptionParser(usage)
parser.add_option("-f")
parser.add_option("-s")
parser.add_option("-u")
parser.add_option("-p")
parser.add_option("-e")
parser.add_option("-c")
parser.add_option("-g")
parser.add_option("-v")

options, arguments = parser.parse_args()

if not options.f or not options.s or not options.u or \
   not options.p or not options.e or not options.c or \
   not options.g or not options.v:
    sys.stderr.write(os.path.basename(sys.argv[0]) + usage[5:])
    sys.exit(1)

policyFile = options.f
serverHost = options.s
userName = options.u
userPass = options.p
userEmail = options.e
clientHost = options.c
globalDbName = options.g
dcVersion = options.v

# TODO... read these from the policyFile
rootU = "becla" # mysql superuser
rootP = ""      # mysql superuser password


admin = MySQLBase(serverHost)
admin.connect(rootU, rootP, globalDbName)

toStr = "TO `%s`@`%s` IDENTIFIED BY '%s'" % (userName, clientHost, userPass)

admin.execCommand0("GRANT ALL ON `%s_%%`.* %s" % (userName, toStr))

admin.execCommand0("GRANT SELECT ON *.* %s" % toStr)

admin.execCommand0("GRANT SELECT, INSERT ON %s.RunInfo %s" % (globalDbName, toStr))

admin.execCommand0("GRANT EXECUTE ON FUNCTION %s.extendRun %s" % \
                   (globalDbName, toStr))

admin.execCommand0("INSERT INTO UserInfo(name, email) VALUES ('%s', '%s')"%\
                   (userName, userEmail))
