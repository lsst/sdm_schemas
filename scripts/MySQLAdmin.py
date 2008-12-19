#!/usr/bin/env python

from __future__ import with_statement
import MySQLdb
import os
import subprocess
import sys


class MySQLAdmin:

    def __init__(self, dbHostName):
        self.dbHostName = dbHostName
        self.db = None
        self.dbOpened = None

    def __del__(self):
        self.disconnect()

    def isConnected(self):
        return self.db != None

    def connect(self, dbUser, dbPassword, dbName=""):

        if self.isConnected():
            if self.dbOpened == dbName:
                return
            self.disconnect()

        try:
            self.db = MySQLdb.connect(self.dbHostName, dbUser, dbPassword, dbName)
        except MySQLdb.Error, e:
            raise RuntimeError("DB Error %d: %s" % (e.args[0], e.args[1]))

        self.dbOpened = dbName
        print "\nConnected to " + dbName

    def disconnect(self):
        if self.db == None:
            return
        try:
            self.db.close()
        except MySQLdb.Error, e:
            raise RuntimeError("DB Error %d: %s" % (e.args[0], e.args[1]))
        self.db = None
        print "\nDisconnected (%s)" % self.dbOpened
        self.dbOpened = None

    # Returns zero row numbers
    def execCommand0(self, command):
        return self.execCommand(command, 0)

    # Returns one row number
    def execCommand1(self, command):
        return self.execCommand(command, 1)

    # Returns multiple row number
    def execCommandN(self, command):
        return self.execCommand(command, 'n')

    # nRowsRet: expected number of rows returned 0/1/n
    def execCommand(self, command, nRowsRet):
        if not self.isConnected():
            raise RuntimeError("No connection (command: '%s')" % command)

        cursor = self.db.cursor()
        print "\nExecuting %s" % command
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

    def loadSqlScript(self, script, dbUser, dbPassword, dbName=""):

        if dbPassword:
            cmd = 'mysql -h%s -u%s -p%s %s' % \
                (self.dbHostName, dbUser, dbPassword, dbName)
        else:
            cmd = 'mysql -h%s -u%s %s' % \
                (self.dbHostName, dbUser, dbName)

        with file(script) as scriptFile:
            if subprocess.call(cmd.split(), stdin=scriptFile) != 0:
                raise RuntimeError("Failed to execute %s < %s" % (cmd, script))
            print "\nExecuted: %s < %s" % (cmd, script)

    # returns % space available for directory where mysql stores data
    def getDataDirSpaceAvail(self):
        row = self.execCommand1("SHOW VARIABLES LIKE 'datadir'")
        mysqlDataDir = row[1]
        st =  os.statvfs(mysqlDataDir)
        return 100 * st.f_bavail / st.f_blocks
