#!/usr/bin/env python

from __future__ import with_statement
import MySQLdb
import os
import subprocess
import sys


class MySQLBase:
    """
    MySQLBase class is a wrapper around MySQLdb. It contains a set of 
    low level basic database utilities such as connecting to database, 
    executing commands or loading sql scripts to database. It caches
    connections, and handles database errors.
    """
    def __init__(self, dbHostName, portNo=3306):
        self.dbHostName = dbHostName
        self.dbHostPort = portNo
        self.db = None
        self.dbOpened = None

    def __del__(self):
        self.disconnect()

    def isConnected(self):
        return self.db != None

    def connect(self, dbUser, dbPassword, dbName=""):
        """
        It connects to database. If a connection is already open it will try to
        reuse it. If it can't it will disconnect it.
        """
        if self.isConnected():
            if self.dbOpened == dbName:
                return
            self.disconnect()

        try:
            self.db = MySQLdb.connect(host=self.dbHostName, 
                                      port=self.dbHostPort,
                                      user=dbUser, 
                                      passwd=dbPassword, 
                                      db=dbName)
        except MySQLdb.Error, e:
            raise RuntimeError("DB Error %d: %s" % (e.args[0], e.args[1]))

        self.dbOpened = dbName
        print "\nConnected to " + dbName

    def disconnect(self):
        if self.db == None:
            return
        try:
            self.db.commit()
            self.db.close()
        except MySQLdb.Error, e:
            raise RuntimeError("DB Error %d: %s" % (e.args[0], e.args[1]))
        self.db = None
        print "\nDisconnected (%s)" % self.dbOpened
        self.dbOpened = None

    def execCommand0(self, command):
        """
        Executes mysql commands which return no rows
        """
        return self.execCommand(command, 0)

    def execCommand1(self, command):
        """
        Executes mysql commands which return one rows
        """
        return self.execCommand(command, 1)

    def execCommandN(self, command):
        """
        Executes mysql commands which return multiple rows
        """
        return self.execCommand(command, 'n')

    def execCommand(self, command, nRowsRet):
        """
        Executes mysql commands which return any number of rows.
        Expected number of returned rows should be given in nRowSet
        """
        if not self.isConnected():
            raise RuntimeError("No connection (command: '%s')" % command)

        cursor = self.db.cursor()
        print "Executing %s" % command
        cursor.execute(command)
        if nRowsRet == 0:
            ret = ""
        elif nRowsRet == 1:
            ret = cursor.fetchone()
        else:
            ret = cursor.fetchall()
        cursor.close()
        print ret
        return ret

    def loadSqlScript(self, scriptPath, dbUser, dbPassword, dbName=""):
        """
        Loads sql script into the database.
        """
        if dbPassword:
            cmd = 'mysql -h%s -u%s -p%s %s' % \
                (self.dbHostName, dbUser, dbPassword, dbName)
        else:
            cmd = 'mysql -h%s -u%s %s' % \
                (self.dbHostName, dbUser, dbName)

        with file(scriptPath) as scriptFile:
            if subprocess.call(cmd.split(), stdin=scriptFile) != 0:
                raise RuntimeError("Failed to execute %s < %s" % \
                                       (cmd,scriptPath))
            print "\nExecuted: %s < %s" % (cmd, scriptPath)

    def getDataDirSpaceAvailPerc(self):
        """
        Returns space available in mysql datadir (percentage volume available)
        """
        row = self.execCommand1("SHOW VARIABLES LIKE 'datadir'")
        mysqlDataDir = row[1]
        st =  os.statvfs(mysqlDataDir)
        return 100 * st.f_bavail / st.f_blocks

    def getDataDirSpaceAvail(self):
        """
        Returns space available in mysql datadir (in kilobytes)
        """
        row = self.execCommand1("SHOW VARIABLES LIKE 'datadir'")
        mysqlDataDir = row[1]
        st =  os.statvfs(mysqlDataDir)
        return st.f_bfree * st.f_bsize / 1024
