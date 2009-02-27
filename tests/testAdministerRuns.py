#!/usr/bin/env python

import lsst.cat.administerRuns as AdminRuns
import lsst.cat.MySQLBase


fakedPolicy = {
    'globalDbName': 'GlobalDB',
    'dcVersion': 'DC3a',
    'sqlDir': '../sql/', # path to the setup files
    'minPercDiskSpaceReq': 10, # minimum disk space required [%]
    'userRunLife': 2  # default lifetime of new user runs [in weeks]
}


def dropDB():
    
    admin = MySQLBase("localhost", 3306)
    admin.connect("becla", "")
    admin.execCommand0("DROP DATABASE IF EXISTS becla_DC3a_u_myFirstRun")
    admin.execCommand0("DROP DATABASE IF EXISTS becla_DC3a_u_mySecondRun")
    admin.execCommand0("DROP DATABASE IF EXISTS becla_DC3a_p_prodRunA")

def markRunFinished(dbName):
    admin = MySQLBase("localhost", 3306)
    admin.connect("becla", "", fakedPolicy['globalDbName'])
    r = admin.execCommand1('SELECT setRunFinished("%s")' % dbName)
    print r

def startSomeRuns():
    x = AdminRuns("localhost", # mysql host
                  3306,        # mysql server port
                  fakedPolicy)

    x.checkStatus("jacek",     # non-superuser
                  "p",         # password
                  "localhost") # machine where mysql client is executed

    r = x.prepareForNewRun("myFirstRun",  "becla", "");
    print 'got: '
    print r
    markRunFinished('becla_DC3a_u_myFirstRun')

    r = x.prepareForNewRun("mySecondRun", "becla", "");
    print 'got: '
    print r
    #markRunFinished('becla_DC3a_u_mySecondRun')

    #x.prepareForNewRun("prodRunA",    "becla", "");

####################################################

# need to call destroyGlobal.py
# need to call setupGlobal.py

dropDB()

startSomeRuns()
