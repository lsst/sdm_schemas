#!/usr/bin/env python

from MySQLAdmin import MySQLAdmin
import MySQLdb
import optparse
import os
import subprocess
import sys

usage = """%prog <policyFile>
"""


# TODO: argument parsing
cl = optparse.OptionParser(usage)
options, arguments = cl.parse_args()

if len(arguments) <1:
    sys.stderr.write(os.path.basename(sys.argv[0]) + usage[5:])
    sys.exit(1)

policyFile = arguments[0]
now = "NOW()"
if (len(arguments) > 1): 
    now = "'%s'" % arguments[1]
#print "now = %s" % now


# Load data from policy file 
# TODO: load this from policy file
dcVersion = "DC3a"
dbHostName = "localhost"
superUserName = "becla"
superUserPassword = ""
globalDbName = "GlobalDB"
daysFirstNotice = 7 # days when first notice is sent before run can be deleted
daysFinalNotice = 1 # days when final notice is sent before run can be deleted


class CleanupExpiredRuns(MySQLAdmin):

    def __init__(self, dbHost, globalDbName, suName, suPassword, dcVer):
        MySQLAdmin.__init__(self, dbHost)
        if globalDbName == "":
            raise RuntimeError("Invalid (empty) global db name")
        if dcVer == "":
            raise RuntimeError("Invalid (empty) dcVer")
        self.globalDbName = globalDbName
        self.suName = suName
        self.suPassword = suPassword
        self.dcVersion = dcVer

        # Finds all runs that expired, which were not deleted yet.
        # Selects only these for which final notification was sent
        # to the users at least 24 hours ago.
        # Returns a list of database names for deletion"""
        self.cmdGetExpiredRuns = """
  SELECT dbName 
  FROM   RunInfo_%s 
  WHERE  TIMEDIFF(%s, expDate) > 0             # run expired
    AND  delDate IS NULL                       # and it is not deleted yet
    AND  finalNotifDate IS NOT NULL            # and notification was sent
    AND  HOUR(TIMEDIFF(%s, finalNotifDate))>23 # ...at least 24 hours ago
""" % (self.dcVersion, now, now)

        # find all runs that will expire in 7 or less days, and
        # and send first notification if it was not sent
        self.cmdGetRunsFirstNotice = """
  SELECT initiator, runName, expDate 
  FROM   RunInfo_%s
  WHERE  DATEDIFF(expDate, %s) > %i
    AND  firstNotifDate IS NULL
""" % (self.dcVersion, now, daysFirstNotice)

        # find all runs that will expire in 1 day or less, for which
        # we sent first notification at least 6 days ago, and
        # send final notification
        self.cmdGetRunsFinalNotice = """
  SELECT initiator, runName, expDate 
  FROM   RunInfo_%s
  WHERE  DATEDIFF(expDate, %s) > %i
    AND  firstNotifDate IS NOT NULL
""" % (self.dcVersion, now, daysFinalNotice)

    def run(self):
        # Connect to database
        self.connect(self.suName, self.suPassword, self.globalDbName)

        # check available disk space and remember it for reporting
        dataDirSpaceAvailBefore = self.getDataDirSpaceAvail()

        # Find which runs expired, delete them and record this
        dbNames = self.execCommandN(self.cmdGetExpiredRuns)
        print "Deleting databases:"
        for dbN in dbNames:
            print dbN
            self.execCommand0("DROP DATABASE %s" % dbN)
            self.execCommand0("UPDATE RunInfo_%s SET delDate=now WHERE " + \
                              "dbName='%s'" % (self.dcVersion, now, dbN))

        # re-check disk space
        dataDirSpaceAvailAfter = self.getDataDirSpaceAvail()

        # Send first notices
        rows = self.execCommandN(self.cmdGetRunsFirstNotice)
        print "Need to send first notification for these:"
        for row in rows:
            print row

       # Send final notices
        rows = self.execCommandN(self.cmdGetRunsFinalNotice)
        print "Need to send final notification for these:"
        for row in rows:
            print row

        # Disconnect from database
        self.disconnect()


xx = CleanupExpiredRuns(dbHostName, globalDbName, superUserName, 
                        superUserPassword, dcVersion)
xx.run()

