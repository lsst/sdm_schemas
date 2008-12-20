#!/usr/bin/env python

import MySQLdb



# assumptions: GlobalDBTest database exists
# and it has schema loaded, eg, we run the following
# mysql -e "drop database GlobalDBTest; create database GlobalDBTest"; mysql GlobalDBTest < ../sql/setup_GlobalDB.sql



# this is the database name used for the test
# (production db not touched)
globalDbName = "GlobalDBTest";




def execMySQLCommand(command, 
                     nRowsRet, # 0/1/m
                     dbName = "",
                     host = "localhost", 
                     user = "becla",
                     password = ""):
    # connect to mysql database
    try:
        db = MySQLdb.connect (host,
                              user,
                              password,
                              dbName)
    except MySQLdb.Error, e:
        print "Error %d: %s" % (e.args[0], e.args[1])
        sys.exit (1)

    cursor = db.cursor()
    #print "executing %s" % command
    cursor.execute(command)
    if nRowsRet == 0:
        ret = ""
    if nRowsRet == 1:
        ret = cursor.fetchone()
    else:
        ret = cursor.fetchall()
    cursor.close()

    # disconnect from database
    db.close()
    return ret







def truncateRunInfo(dcVer):
   cmd = "TRUNCATE RunInfo_%s " % dcVer
   execMySQLCommand(cmd, 0, globalDbName)


def registerRun(userName, runName, dcVer, runType, dateStarted):
    cmd = "INSERT INTO RunInfo_%s(runName, dbName, startDate, initiator, expDate) VALUES('%s', '%s_%s_%s_%s', '%s', '%s', DATE_ADD('%s', INTERVAL 2 WEEK))" % (dcVer, runName, userName, dcVer, runType, runName, dateStarted, userName, dateStarted)
    execMySQLCommand(cmd, 0, globalDbName)


def extendRun(userName, runName):
    cmd = "SELECT extendRun('%s', '%s')" % (runName, userName)
    execMySQLCommand(cmd, 1, globalDbName)




# insert some dummy data
registerRun('becla', 'firstRun', 'DC3a', 'u', '2008-12-06')
registerRun('becla', 'myTest',   'DC3a', 'u', '2008-12-07')
registerRun('becla', 'run2',     'DC3a', 'u', '2008-12-07')
registerRun('becla', 'run3',     'DC3a', 'u', '2008-12-08')
registerRun('becla', 'run3',     'DC3a', 'u', '2008-12-08') # duplicate run name
registerRun('becla', 'run4',     'DC3a', 'u', '2008-12-09')
registerRun('becla', 'run5',     'DC3a', 'u', '2008-12-19')
registerRun('becla', 'run6',     'DC3a', 'u', '2008-12-11')
registerRun('becla', 'run7',     'DC3a', 'u', '2008-12-12')
registerRun('becla', 'run8',     'DC3a', 'u', '2008-12-13')
registerRun('becla', 'run9',     'DC3a', 'u', '2008-12-14')
registerRun('becla', 'run10',    'DC3a', 'u', '2008-12-14')
registerRun('becla', 'run11',    'DC3a', 'u', '2008-12-15')
registerRun('becla', 'run12',    'DC3a', 'u', '2008-12-16')
registerRun('becla', 'run13',    'DC3a', 'u', '2008-12-17')
registerRun('becla', 'run14',    'DC3a', 'u', '2008-12-18')
registerRun('serge', 'myTest',   'DC3a', 'u', '2008-12-09') # notice, this run name was used
registerRun('serge', 'apTest1',  'DC3a', 'u', '2008-12-09')
registerRun('kt',    'x',        'DC3a', 'u', '2008-12-16')


execMySQLCommand("""
  INSERT INTO UserInfo_DC3a VALUES 
    ("becla", "becla@slac.stanford.edu"),
    ("serge", "serge@x.y")
""", 0, globalDbName);



# extend one run
extendRun('becla', 'run5')


# pretend first and final notifications were sent
cmd = "UPDATE RunInfo_DC3a SET firstNotifDate='2008-12-10', finalNotifDate='2008-12-11' WHERE runInfoId=3"
execMySQLCommand(cmd, 1, globalDbName)

