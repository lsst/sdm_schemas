#!/usr/bin/env python

from mysqlBase import MySQLBase
import getpass
import os
import subprocess
import sys


"""This file contains a set of utilities to manage runs"""


class AdminBase(MySQLBase):
    """
    Base class. Extracts and stores information from 
    policy object.
    """

    def __init__(self, dbHostName, portNo, policyObject):
        MySQLBase.__init__(self, dbHostName, portNo)

        self.globalDbName = policyObject['globalDbName']
        self.dcVersion = policyObject['dcVersion']
        self.sqlDir = policyObject['sqlDir']
        self.minPercDiskSpaceReq = policyObject['minPercDiskSpaceReq']
        self.userRunLife = policyObject['userRunLife']

        if self.globalDbName == "":
            raise RuntimeError("Invalid (empty) global db name")
        if self.dcVersion == "":
            raise RuntimeError("Invalid (empty) dcVersion name")
        if not os.path.exists(self.sqlDir):
            raise RuntimeError("Directory '%s' not found" % self.sqlDir)

        self.dcDbName = '%s_DB' % self.dcVersion


class SUAdmin(AdminBase):
    """
    Class SUAdmin contains a set of utils to administer LSST-specific
    contents of the database. It requires mysql superuser access.
    In particular, it helps to setup global database and the 
    per-data-challenge database.
    """

    def __init__(self, dbHostName, portNo, policyObject):
        AdminBase.__init__(self, dbHostName, portNo, policyObject)
        self.dbSUName = raw_input("Enter mysql superuser account name: ")
        self.dbSUPwd = getpass.getpass()


    def setupOnceGlobal(self):
        """
        setupOnceGlobal creates and configures Global database. 
        This function should be executed only once.
        """
        # create and configure global database
        self.__setupOnce__(self.globalDbName, 'setup_DB_global.sql')


    def setupOnceDataChallenge(self):
        """
        setupOnceDataChallenge creates and configures data-challenge
        specific database. It should be executed once for each DC.
        """
        # create and configure per-DC database
        self.__setupOnce__(self.dcDbName, 'setup_DB_dataChallenge.sql')
        # also load the regular per-run schema
        fN = "lsstSchema4mysql%s.sql" % self.dcVersion
        p = os.path.join(self.sqlDir, fN)
        self.loadSqlScript(p, self.dbSUName, self.dbSUPwd, self.dcDbName)


    def __setupOnce__(self, dbName, setupScript):
        # Verify that the setup file exist
        setupPath = os.path.join(self.sqlDir, setupScript)
        if not os.path.exists(setupPath):
            raise RuntimeError("Can't find schema file '%s'" % setupPath)

        # Create database
        self.connect(self.dbSUName, self.dbSUPwd)
        self.execCommand0("CREATE DATABASE " + dbName)
        self.disconnect()

        # Configure the database
        self.loadSqlScript(setupPath, self.dbSUName, self.dbSUPwd, dbName)



class AdminRuns(AdminBase):
    """
    Class AdminRuns contains a set of utils to administer LSST-specific
    contents of the database which do not require mysql superuser access.
    In particular, it helps to setup verify  status of global database(s)
    and user-specific database settings prior to starting a run, and 
    allows to register run in global database.
    """

    def __init(self, dbHostName, portNo, policyObject):
        AdminBase.__init__(self, dbHostName, portNo, policyObject)


    def checkStatus(self, userName, userPassword, clientMachine):
        """
        checkStatus checks status of global database and user-specific 
        database settings such as authorizations. It should be called 
        prior to starting a run.
        """

        # Check if Global database and its tables exist
        self.connect(userName, userPassword, self.globalDbName)
        self.execCommand0("DESC RunInfo")
        self.disconnect()

        # Check if per-DC database and its tables exist
        self.connect(userName, userPassword, self.dcDbName)
        self.execCommand0("DESC prv_RunDbNameToRunCode")
        self.execCommand0("DESC prv_PolicyFile")
        self.disconnect()

        # check if user has appropriate database privileges
        # notice we are not dealing with different variations
        # (wildcards etc) for the host name, so this is a very
        # crude verification.
        cmd = "SELECT Table_priv FROM tables_priv WHERE " + \
            "user='%s' AND Table_name='RunInfo'" % \
            (userName)
        self.connect(userName, userPassword, "mysql")
        row = self.execCommand1(cmd)
        if (row is not None):
            self.disconnect()
            return
        cmd = "SELECT Insert_priv FROM mysql.user WHERE " + \
              "user='%s'" % (userName)
        row = self.execCommand1(cmd)
        self.disconnect()
        if (row is not None) and (str(row[0])=="Y"):
            return
        # uc = "'%s:%s'" % (userName, clientMachine)
        uc = userName
        raise RuntimeError("Database authorization failure for %s" % uc)


    def prepareForNewRun(self, runName, userName, userPassword, runType='u'):
        """
        prepareForNewRun prepares database for a new run. This includes
        creating appropriate database(s) and tables(s) as well as preloading
        some static database contents and registering the run in the 
        global database. It returns a database name corresponding to the
        run that is starting.
        Returns the entire database logical location string in the form:
        "mysql://hostName:port/databaseName"
        """
        if (runType != 'p' and runType != 'u'):
            raise RuntimeError("Invalid runType '%c', expected 'u' or 'p'" % \
                               runType)
        if runName == "":
            raise RuntimeError("Invalid (empty) runName")

        print "prepareForNewRun(%s, %s, %s, %s)" % \
              (runName, runType, userName, userPassword)

        # prepare list of sql scripts to load
        fN = "lsstSchema4mysql%s.sql" % self.dcVersion
        dbScripts = [os.path.join(self.sqlDir, fN),
                     os.path.join(self.sqlDir, "setup_storedFunctions.sql"),
                     os.path.join(self.sqlDir, "setup_sdqa.sql"),
                     os.path.join(self.sqlDir, "setup_perRunTables.sql")]

        # Verify these scripts exist
        for f in dbScripts:
            if not os.path.exists(f):
                raise RuntimeError("Can't find file '%s'" % f)

        # connect to the global database
        self.connect(userName, userPassword, self.globalDbName)

        # check if available disk space is not below required limit
        # for that directory
        percDiskSpaceAvail = self.getDataDirSpaceAvailPerc()
        if percDiskSpaceAvail < self.minPercDiskSpaceReq:
            self.disconnect()
            raise RuntimeError(
                "Not enough disk space available in mysql " +
                "datadir, required %i%%, available %i%%" % 
                (self.minPercDiskSpaceReq, percDiskSpaceAvail))

        if runType == 'p':
            runLife = 1000 # ensure this run "never expire"
            # TODO: check if userName is authorized to start production run
        else:
            runLife = self.userRunLife

        # create database for this new run
        # format: <userName>_<DC version>_<u|p>_<run number or name>
        runDbName = "%s_%s_%c_%s" % (userName, self.dcVersion, runType, runName)
        self.execCommand0("CREATE DATABASE %s" % runDbName)

        # load all scripts
        for fP in dbScripts:
            self.loadSqlScript(fP, userName, userPassword, runDbName)

        # Register this run in the global database
        cmd = """INSERT INTO RunInfo 
                 (runName, dcVersion, dbName, startDate, expDate, initiator)
                 VALUES ("%s", "%s", "%s", NOW(), 
                     DATE_ADD(NOW(), INTERVAL %i WEEK), "%s")""" % \
            (runName, self.dcVersion, runDbName, runLife, userName)
        self.execCommand0(cmd)

        # Disconnect from database
        self.disconnect()

        return "mysql://%s:%i/%s" % \
                (self.dbHostName, self.dbHostPort, runDbName)


    def runFinished(dbName):
        """
        Should be called after the run finished. This 
        function records in the GlobalDB the fact that
        the run finished (date, maybe status, etc).
        It take an argument: databaseName"
        """

        self.connect(userName, userPassword, self.globalDbName)
        self.execCommand0("DESC RunInfo")
        self.disconnect()
