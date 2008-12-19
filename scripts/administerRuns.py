#!/usr/bin/env python

from __future__ import with_statement
import MySQLdb
import os
import subprocess
import sys


"""This file contains a set of utilities to manage runs"""


class AdminRuns:
    """
Manage information about runs in database.
    """

    def __init__(self,
                 dbHostName,
                 dbSuperUserName,
                 dbSuperUserPassword,
                 globalDbName):
        if globalDbName == "":
            raise RuntimeError("Invalid (empty) global db name")

        self.dbHostName = dbHostName
        self.dbSuperUserName = dbSuperUserName
        self.dbSuperUserPassword = dbSuperUserPassword
        self.globalDbName = globalDbName

    def setupGlobalDB(self, policyFile):
        """Set up Global Database. This should be executed only once.
Warning: it requires mysql superuser password."""

        # Load data from the policy file
        #if not os.path.exists(policyFile):
            #raise RuntimeError("Policy file'%s' not found" % policyFile)
        # TODO: load this from policy file
        sqlDir = "../sql/" # path to the file setup_GlobalDB.sql

        # Verify that the schema file exists
        sqlFilePath = os.path.join(sqlDir, "setup_GlobalDB.sql")
        if not os.path.exists(sqlFilePath):
            raise RuntimeError("Can't find schema file '%s'" % sqlFilePath)

        # Connect to mysql database
        try:
            db = MySQLdb.connect(self.dbHostName,
                                 self.dbSuperUserName,
                                 self.dbSuperUserPassword)
        except MySQLdb.Error, e:
            raise RuntimeError("DB Error %d: %s" % (e.args[0], e.args[1]))

        # Create Global database
        cursor = db.cursor()
        try:
            cursor.execute("CREATE DATABASE " + self.globalDbName)
        except MySQLdb.Error, e:
            raise RuntimeError("DB Error %d: %s" % (e.args[0], e.args[1]))
        # close db connection
        cursor.close()
        db.close()

        # Load schema
        if self.dbSuperUserPassword:
            cmd = 'mysql -h%s -u%s -p%s %s' % \
                (self.dbHostName, self.dbSuperUserName, 
                 self.dbSuperUserPassword, self.globalDbName)
        else:
            cmd = 'mysql -h%s -u%s %s' % \
                (self.dbHostName, self.dbSuperUserName, self.globalDbName)
        with file(sqlFilePath) as sqlFile:
            if subprocess.call(cmd.split(), stdin=sqlFile) != 0:
                raise RuntimeError("Failed to execute " + sqlFilePath)


    def checkStatus(self, policyFile, userName, userPassword, clientMachine):
        """Checks status of global database and checks 
        whether user is authorized to start a run"""

        # Load data from the policy file
        #if not os.path.exists(policyFile):
            #raise RuntimeError("Policy file'%s' not found" % policyFile)
        # TODO: load this from policy file
        sqlDir = "../sql/" # path to the file setup_GlobalDB.sql
        dcVersion = "DC3a"

        try:
            # Try opening Global database
            db = MySQLdb.connect (self.dbHostName, userName, 
                                  userPassword, self.globalDbName)
            cursor = db.cursor()

            # check if RunInfo_<dc version> table exists
            cursor.execute("DESC RunInfo_" + dcVersion)

            # check if UserInfo_<dc version> table exists
            cursor.execute("DESC UserInfo_" + dcVersion)

            # check if user has appropriate database privileges
            cmd = """
                SELECT Insert_priv 
                FROM mysql.user 
                WHERE user='%s' AND host='%s'""" % \
                               (userName, clientMachine)
            cursor.execute(cmd)
            row = cursor.fetchone()
            if row == None:
                raise RuntimeError(
                    "Database authorization failure for '%s:%s'" % \
                        (userName, clientMachine))
            if str(row[0]) != "Y":
                raise RuntimeError(
                    "Database authorization failure for '%s:%s'" % \
                        (userName, clientMachine))

            # close database connection
            cursor.close()
            db.close()
        except MySQLdb.Error, e:
            raise RuntimeError("DB Error %d: %s" % (e.args[0], e.args[1]))

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
        minDisk = 10 # minimum disk space required [%]
        runLife = 2  # default lifetime of new runs measured [weeks]
        dcVersion = "DC3a"
        sqlDir = "../sql"
        superUsers = "" # list of user authorized to start production runs

        # Verify that all needed sql files exist
        fN = "lsstSchema4mysql%s.sql" % dcVersion
        sqlSchemaFilePath = os.path.join(sqlDir, fN)
        sqlStFuncFilePath = os.path.join(sqlDir, "setup_storedFunctions.sql")
        sqlSdqaFilePath   = os.path.join(sqlDir, "setup_sdqa.sql")
        sqlPerRFilePath   = os.path.join(sqlDir, "setup_perRunTables.sql")
        for f in (sqlSchemaFilePath, sqlStFuncFilePath, \
                      sqlSdqaFilePath, sqlPerRFilePath):
            if not os.path.exists(f):
                raise RuntimeError("Can't find file '%s'" % f)

        # check if disk space is not below this limit
        # if it is, issue an alert and exit
        # TODO ...

        if runType == 'p':
            runLife = 1000 # ensure this run "never expire"
            # check if userName is authorized to start production run
            # TODO...

       # Connect to mysql database
        try:
            db = MySQLdb.connect(self.dbHostName, userName, userPassword)
        except MySQLdb.Error, e:
            raise RuntimeError("DB Error %d: %s" % (e.args[0], e.args[1]))

        # assemble db name
        # format: <userName>_<DC version>_<u|p>_<run number or name>
        runDbName = "%s_%s_%c_%s" % (userName, dcVersion, runType, runName)

        # create database for this new run
        cursor = db.cursor()
        try:
            cursor.execute("CREATE DATABASE %s" % runDbName)
        except MySQLdb.Error, e:
            raise RuntimeError("DB Error %d: %s" % (e.args[0], e.args[1]))

        # close connection to the run database
        cursor.close()
        db.close()

        # Prepare command for loading
        if userPassword:
            cmd = 'mysql -h%s -u%s -p%s %s' % \
                (self.dbHostName, userName, userPassword, runDbName)
        else:
            cmd = 'mysql -h%s -u%s %s' % \
                (self.dbHostName, userName, runDbName)

        # load schema, stored function, sdqa and per-run stuff
        for fP in (sqlSchemaFilePath, sqlStFuncFilePath, \
                       sqlSdqaFilePath, sqlPerRFilePath):
            f = file(fP)
            if subprocess.call(cmd.split(), stdin=f) != 0:
                raise RuntimeError("Failed to execute " + fP)

        # open connection to the Global database
        try:
            db = MySQLdb.connect(self.dbHostName, userName,
                                 userPassword, self.globalDbName)
        except MySQLdb.Error, e:
            raise RuntimeError("DB Error %d: %s" % (e.args[0], e.args[1]))

        # register this run in the global database
        cmd = """INSERT INTO RunInfo_DC3a 
                        (runName, dbName, startDate, expDate, initiator) 
                 VALUES ("%s", "%s", NOW(), 
                         DATE_ADD(NOW(), INTERVAL %i WEEK), "%s")""" % \
            (runName, runDbName, runLife, userName)
        cursor = db.cursor()
        try:
            cursor.execute(cmd)
        except MySQLdb.Error, e:
            raise RuntimeError("DB Error %d: %s" % (e.args[0], e.args[1]))
        cursor.close()
        db.close()


## --------------------------------- ##
## code below used to test things... ##
## --------------------------------- ##

x = AdminRuns("localhost", # mysql host
              "becla",     # mysql superuser
              "",          # mysql superuser password
              "GlobalDB")  # global db name


x.setupGlobalDB("globalDBPolicy.txt")

x.checkStatus("perRunDBPolicy.txt", 
              "becla",     # non-superuser
              "",          # password
              "localhost") # machine where mysql client is executed

x.prepareForNewRun("perRunDBPolicy.txt", "myFirstRun",  "u", "becla", "");
x.prepareForNewRun("perRunDBPolicy.txt", "mySecondRun", "u", "becla", "");
x.prepareForNewRun("perRunDBPolicy.txt", "prodRunA",    "p", "becla", "");
