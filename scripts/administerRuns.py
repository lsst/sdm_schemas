#!/usr/bin/env python

import MySQLdb
from MySQLAdmin import MySQLAdmin
import os
import subprocess
import sys


"""This file contains a set of utilities to manage runs"""


class AdminRuns(MySQLAdmin):
    """
Manage information about runs in database.
    """

    def __init__(self, dbHostName, globalDbName):
        MySQLAdmin.__init__(self, dbHostName)
        if globalDbName == "":
            raise RuntimeError("Invalid (empty) global db name")
        self.globalDbName = globalDbName


    def setupGlobalDB(self, policyFile):
        """Set up Global Database. This should be executed only once.
Warning: it requires mysql superuser password."""

        # Load data from the policy file
        #if not os.path.exists(policyFile):
            #raise RuntimeError("Policy file'%s' not found" % policyFile)
        # TODO: load this from policy file
        sqlDir = "../sql/" # path to the file setup_GlobalDB.sql
        dbSuperUserName = "becla"
        dbSuperUserPassword = ""

        # Verify that the schema file exists
        sqlFilePath = os.path.join(sqlDir, "setup_GlobalDB.sql")
        if not os.path.exists(sqlFilePath):
            raise RuntimeError("Can't find schema file '%s'" % sqlFilePath)

        # Create global database
        self.connect(dbSuperUserName, dbSuperUserPassword)
        self.execCommand0("CREATE DATABASE " + self.globalDbName)
        self.disconnect()

        # Load schema
        self.loadSqlScript(sqlFilePath, dbSuperUserName, 
                           dbSuperUserPassword, self.globalDbName)


    def checkStatus(self, policyFile, userName, userPassword, clientMachine):
        """Checks status of global database and checks 
        whether user is authorized to start a run"""

        # Load data from the policy file
        #if not os.path.exists(policyFile):
            #raise RuntimeError("Policy file'%s' not found" % policyFile)
        # TODO: load this from policy file
        sqlDir = "../sql/" # path to the file setup_GlobalDB.sql
        dcVersion = "DC3a"

        # Check if Global database and its tables exist
        self.connect(userName, userPassword, self.globalDbName)
        self.execCommand0("DESC RunInfo_" + dcVersion)
        self.execCommand0("DESC UserInfo_" + dcVersion)

        # check if user has appropriate database privileges
        cmd = "SELECT Insert_priv FROM mysql.user WHERE " + \
              "user='%s' AND host='%s'" % (userName, clientMachine)
        row = self.execCommand1(cmd)
        self.disconnect()
        if row is None or ((row is not None) and (str(row[0])!="Y")):
            uc = "'%s:%s'" % (userName, clientMachine)
            raise RuntimeError("Database authorization failure for %s" % uc)


    def prepareForNewRun(self, policyFile, runName, 
                         runType, # runType: 'u' or 'p' 
                         userName, userPassword):
        if (runType != 'p' and runType != 'u'):
            raise RuntimeError("Invalid runType '%c', expected 'u' or 'p'" % \
                                   runType)
        if runName == "":
            raise RuntimeError("Invalid (empty) runName")

        # Load data from the policy file
        #if not os.path.exists(policyFile):
            #raise RuntimeError("Policy file'%s' not found" % policyFile)
        # TODO: load this from policy file
        minPercDiskSpaceReq = 10 # minimum disk space required [%]
        runLife = 2  # default lifetime of new runs measured [weeks]
        dcVersion = "DC3a"
        sqlDir = "../sql"
        superUsers = "" # list of user authorized to start production runs

        # prepare list of sql scripts to load
        fN = "lsstSchema4mysql%s.sql" % dcVersion
        dbScripts = [os.path.join(sqlDir, fN),
                     os.path.join(sqlDir, "setup_storedFunctions.sql"),
                     os.path.join(sqlDir, "setup_sdqa.sql"),
                     os.path.join(sqlDir, "setup_perRunTables.sql")]
        # Verify these scripts exist
        for f in dbScripts:
            if not os.path.exists(f):
                raise RuntimeError("Can't find file '%s'" % f)

        # connect to the global database
        self.connect(userName, userPassword, self.globalDbName)

        # check if available disk space is not below required limit
        # for that directory
        percDiskSpaceAvail = self.getDataDirSpaceAvail()
        if percDiskSpaceAvail < minPercDiskSpaceReq:
            raise RuntimeError(
                "Not enough disk space available in mysql " +
                "datadir, required %i%%, available %i%%" % 
                (minPercDiskSpaceReq, percDiskSpaceAvail))

        if runType == 'p':
            runLife = 1000 # ensure this run "never expire"
            # check if userName is authorized to start production run
            # TODO...

        # create database for this new run
        # format: <userName>_<DC version>_<u|p>_<run number or name>
        runDbName = "%s_%s_%c_%s" % (userName, dcVersion, runType, runName)
        self.execCommand0("CREATE DATABASE %s" % runDbName)

        # load all scripts
        for fP in dbScripts:
            self.loadSqlScript(fP, userName, userPassword, runDbName)

        # Register this run in the global database
        cmd = """INSERT INTO RunInfo_DC3a 
                    (runName, dbName, startDate, expDate, initiator) 
                 VALUES ("%s", "%s", NOW(), 
                     DATE_ADD(NOW(), INTERVAL %i WEEK), "%s")""" % \
            (runName, runDbName, runLife, userName)
        self.execCommand0(cmd)

        # Disconnect from database
        self.disconnect()
