#!/usr/bin/env python

install lsst.cat.MySQLBase
import getpass

fakedPolicy = {
    'globalDbName': 'GlobalDB',
    'dcVersion': 'DC3a' }


# Pull in some key-values from the policy
globalDbName = fakedPolicy['globalDbName']
dcVersion = fakedPolicy['dcVersion']

dcDbName = "%s_DB" % dcVersion

print """
             ** WARNING **
   You are attempting to destroy the '%s' database 
   and the '%s' database - think twice before proceeding!
""" % (globalDbName, dcDbName)

dbSUName = raw_input("Enter mysql superuser account name: ")
dbSUPwd = getpass.getpass()

x = MySQLBase("localhost", 3306)
x.connect(dbSUName, dbSUPwd)
x.execCommand0("DROP DATABASE IF EXISTS " + globalDbName)
x.execCommand0("DROP DATABASE IF EXISTS " + dcDbName)
