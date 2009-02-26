#!/usr/bin/env python

from lsst.cat.mysqlBase import MySQLBase
import getpass
import os
import sys


usage = """

%prog initializes the LSST Global database and 
per-data-challenge database. Requires CAT_ENV
environment variable.
"""


class SetupGlobal(MySQLBase):
    def __init__(self, dbHostName, portNo, policyObject):
        MySQLBase.__init__(self, dbHostName, portNo)

        # Pull in some key-values from the policyObject.
        for n in ['globalDbName', 'dcVersion']:
            setattr(self, n, policyObject.get(n, "")) # empty default
        if self.globalDbName == "":
            raise RuntimeError("Invalid (empty) global db name")
        if self.dcVersion == "":
            raise RuntimeError("Invalid (empty) dcVersion name")
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
        # first create & configure Global database (if doesn't exist)
        if self.dbExists(self.dbSUName, self.dbSUPwd, self.globalDbName):
            print "%s exists" % self.globalDbName
        else:
            self.__setupOnce__(self.globalDbName, 'setup_DB_global.sql')

        # create and configure per-data-challange database (if doesn't exist)
        dcDbName = '%s_DB' % self.dcVersion
        if self.dbExists(self.dbSUName, self.dbSUPwd, dcDbName):
            print "%s exists" % dcDbName
        else:
            self.__setupOnce__(dcDbName, 'setup_DB_dataChallenge.sql')
            # also load the regular per-run schema
            fN = "lsstSchema4mysql%s.sql" % self.dcVersion
            p = os.path.join(self.sqlDir, fN)
            self.loadSqlScript(p, self.dbSUName, self.dbSUPwd, dcDbName)

    def __setupOnce__(self, dbName, setupScript):
        # Verify that the setupScript exist
        setupPath = os.path.join(self.sqlDir, setupScript)
        if not os.path.exists(setupPath):
            raise RuntimeError("Can't find schema file '%s'" % setupPath)
        # Create database
        self.connect(self.dbSUName, self.dbSUPwd)
        self.execCommand0("CREATE DATABASE " + dbName)
        self.disconnect()
        # Configure database
        self.loadSqlScript(setupPath, self.dbSUName, self.dbSUPwd, dbName)




# these should be fetched from policies [to-do]
dbHost = 'localhost'
portNo = 3306
fakedPolicy = {
    'globalDbName': 'GlobalDB',
    'dcVersion': 'DC3a',
}

x = SetupGlobal(dbHost, portNo, fakedPolicy)
x.run()
