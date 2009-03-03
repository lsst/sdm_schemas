#!/usr/bin/env python

from lsst.cat.MySQLBase import MySQLBase
from lsst.cat.policyReader import PolicyReader
import lsst.pex.policy as pexPolicy

import getpass
import optparse
import os
import sys


usage = """

%prog [-f policyFile]

Initializes the LSST Global database and per-data-challenge database. 

Requires $CAT_ENV environment variable.

If the policy file is not specified, the default
one will be used: $CAT_DIR/defaultCatPolicy.paf

"""


class SetupGlobal(MySQLBase):
    def __init__(self, dbHostName, portNo, globalDbName, dcVersion):
        MySQLBase.__init__(self, dbHostName, portNo)

        if globalDbName == "":
            raise RuntimeError("Invalid (empty) global db name")
        self.globalDbName = globalDbName

        if dcVersion == "":
            raise RuntimeError("Invalid (empty) dcVersion name")
        self.dcVersion = dcVersion

        # Pull in sqlDir from CAT_DIR
        self.sqlDir = os.getenv('CAT_DIR')
        if not self.sqlDir:
            raise RuntimeError('CAT_DIR env variable not set')
        self.sqlDir = os.path.join(os.environ["CAT_DIR"], "sql")
        if not os.path.exists(self.sqlDir):
            raise RuntimeError("Directory '%s' not found" % self.sqlDir)

        self.dbSUName = raw_input("Enter mysql superuser account name: ")
        self.dbSUPwd = getpass.getpass()

    def run(self):
        """
        setupGlobal creates and per-data-challenge database,
        and optionally (if it does not exist) the Global database. 
        """
        self.connect(self.dbSUName, self.dbSUPwd)
        # create & configure Global database (if doesn't exist)
        if self.dbExists(self.globalDbName):
            print "'%s' exists." % self.globalDbName
        else:
            self.__setupOnce__(self.globalDbName, 'setup_DB_global.sql')
            print "Setup '%s' succeeded." % self.globalDbName
            
        # create and configure per-data-challange database (if doesn't exist)
        dcDbName = '%s_DB' % self.dcVersion
        if self.dbExists(dcDbName):
            print "'%s' exists." % dcDbName
        else:
            self.__setupOnce__(dcDbName, 'setup_DB_dataChallenge.sql')
            # also load the regular per-run schema
            fN = "lsstSchema4mysql%s.sql" % self.dcVersion
            p = os.path.join(self.sqlDir, fN)
            self.loadSqlScript(p, self.dbSUName, self.dbSUPwd, dcDbName)
            print "Setup '%s' succeeded." % dcDbName

        self.disconnect()

    def __setupOnce__(self, dbName, setupScript):
        # Verify that the setupScript exist
        setupPath = os.path.join(self.sqlDir, setupScript)
        if not os.path.exists(setupPath):
            raise RuntimeError("Can't find schema file '%s'" % setupPath)
        # Create database
        self.createDb(dbName)
        # Configure database
        self.loadSqlScript(setupPath, self.dbSUName, self.dbSUPwd, dbName)


parser = optparse.OptionParser(usage)
parser.add_option("-f")

options, arguments = parser.parse_args()

r = PolicyReader(None, options.f)
(serverHost, serverPort, globalDbName, dcVersion) = r.readIt()

x = SetupGlobal(serverHost, serverPort, globalDbName, dcVersion)
x.run()
