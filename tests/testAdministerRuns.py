#!/usr/bin/env python

from lsst.cat.administerRuns import AdminRuns
from lsst.cat.MySQLBase import MySQLBase
from lsst.cat.policyReader import PolicyReader

import getpass


r = PolicyReader()
(host, port) = r.readAuthInfo()
(globalDbName, dcVersion, dcDb, \
 minPercDiskSpaceReq, userRunLife) = r.readGlobalSetup()


usr = raw_input("Enter mysql account name: ")
pwd = getpass.getpass()


def dropDB():
    
    admin = MySQLBase(host, port)
    admin.connect(usr, pwd)
    admin.dropDb('%s_%s_u_myFirstRun' % (usr, dcVersion))
    admin.dropDb('%s_%s_u_mySecondRun' % (usr, dcVersion))
    admin.dropDb('%s_%s_p_prodRunA' % (usr, dcVersion))

def markRunFinished(dbName):
    admin = MySQLBase(host, port)
    admin.connect(usr, pwd, globalDbName)
    r = admin.execCommand1("SELECT setRunFinished('%s')" % dbName)
    print r

def startSomeRuns():
    x = AdminRuns(host, port, globalDbName, dcVersion,
                  dcDb, minPercDiskSpaceReq, userRunLife)

    x.checkStatus(usr, pwd, host)

    r = x.prepareForNewRun('myFirstRun',  usr, pwd);
    print r
    markRunFinished('%s_%s_u_myFirstRun' %(usr, dcVersion))

    r = x.prepareForNewRun('mySecondRun', usr, pwd);
    print r
    #markRunFinished('%s_%s_u_mySecondRun' %(usr, dcVersion))


####################################################

# need to call destroyGlobal.py
# need to call setupGlobal.py

dropDB()

startSomeRuns()
