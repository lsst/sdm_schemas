#!/usr/bin/env python

from lsst.cat.administerRuns import AdminRuns
from lsst.cat.MySQLBase import MySQLBase


fakedPolicy = {
    'globalDbName': 'GlobalDB',
    'dcVersion': 'DC3a',
    'sqlDir': '../sql/', # path to the setup files
    'minPercDiskSpaceReq': 10, # minimum disk space required [%]
    'userRunLife': 2  # default lifetime of new user runs [in weeks]
}

host = "localhost"
port = 3306
usr = 'jacek'
uwd = 'p'



def dropDB():
    
    admin = MySQLBase(host, port)
    admin.connect(usr, pwd)
    admin.dropDb('%s_%s_u_myFirstRun' % (usr, fakedPolicy[dcVersion]))
    admin.dropDb('%s_%s_u_mySecondRun' % (usr, fakedPolicy[dcVersion]))
    admin.dropDb('%s_%s_p_prodRunA' % (usr, fakedPolicy[dcVersion]))

def markRunFinished(dbName):
    admin = MySQLBase(host, port)
    admin.connect(usr, pwd, fakedPolicy['globalDbName'])
    r = admin.execCommand1('SELECT setRunFinished("%s")' % dbName)
    print r

def startSomeRuns():
    x = AdminRuns(host, port, fakedPolicy)

    x.checkStatus(usr, pwd, 'localhost')

    r = x.prepareForNewRun('myFirstRun',  usr, pwd);
    print r
    markRunFinished('%s_%s_u_myFirstRun' %(usr, fakedPolicy[dcVersion]))

    r = x.prepareForNewRun('mySecondRun', usr, pwd);
    print r
    #markRunFinished('%s_%s_u_mySecondRun' %(usr, fakedPolicy[dcVersion]))


####################################################

# need to call destroyGlobal.py
# need to call setupGlobal.py

dropDB()

startSomeRuns()
