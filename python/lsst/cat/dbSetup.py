#!/usr/bin/env python

# 
# LSST Data Management System
# Copyright 2008, 2009, 2010 LSST Corporation.
# 
# This product includes software developed by the
# LSST Project (http://www.lsst.org/).
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the LSST License Statement and 
# the GNU General Public License along with this program.  If not, 
# see <http://www.lsstcorp.org/LegalNotices/>.
#


from lsst.cat.MySQLBase import MySQLBase
import os
import subprocess
import sys


class DbSetup(MySQLBase):
    """
    This file contains a set of utilities to manage per-user databases
    """

    def __init__(self, dbHostName, portNo, userName, userPwd,
                 dirEnviron="CAT_DIR", subDir="sql", userDb=""):
        '''
        This defaults to values for the cat database.
        '''
        MySQLBase.__init__(self, dbHostName, portNo)
        self.userName = userName
        if self.userName == "":
            raise RuntimeError("Invalid (empty) userName")
        self.userPwd = userPwd
        self.sqlDir = os.path.join(os.environ[dirEnviron], subDir)
        if not os.path.exists(self.sqlDir):
            raise RuntimeError("Directory '%s' not found" % self.sqlDir)
        if (userDb == ""):
            self.userDb = '%s_dev' % userName
        else:
            self.userDb = userDb

    def setupUserDb(self):
        """
        Sets up user database (creates and loads stored procedures/functions).
        Database name: <userName>_dev.
        If the database exists, it will remove it first.
        """
        scripts = ("lsstSchema4mysqlDC3a.sql", "setup_storedFunctions.sql")
        self.setupDb(scripts)

    def setupDb(self, scriptFiles):
        '''
        Setup a user database using the user and database information provided to
        the constructor and the schema provided by the scriptFiles.
        If the database already exists, it will be destroyed first.
        '''
        dbScripts = []
        for script in scriptFiles:
            dbScripts.append(os.path.join(self.sqlDir, script))
        # Check that scripts exist
        for f in dbScripts:
            if not os.path.exists(f):
                raise RuntimeError("Can't find file '%s'" % f)

        # Delete and (re-)create database
        print self.userName, self.dbHostName, self.userDb
        self.connect(self.userName, self.userPwd)
        if self.dbExists(self.userDb):
            self.dropDb(self.userDb)
        self.createDb(self.userDb)
        self.disconnect()

        # load the scripts
        self.connect(self.userName, self.userPwd, dbName=self.userDb)
        for f in dbScripts:
            self.loadSqlScript(f, self.userName, self.userPwd, self.userDb)

    def dropUserDb(self):
        self.connect(self.userName, self.userPwd)
        if self.dbExists(self.userDb):
            self.dropDb(self.userDb)
        self.disconnect()

