#!/usr/bin/env python


from lsst.cat.MySQLBase import MySQLBase
from lsst.cat.policyReader import PolicyReader
import getpass
import os


r = PolicyReader()
(host, port) = r.readAuthInfo()

usr = raw_input('Enter mysql user name: ')
pwd = getpass.getpass()

dbn = 'dummy_Test_DB_375Ef_4DRf56'
sqlDir = os.path.join(os.environ["CAT_DIR"], 'sql')

x = MySQLBase(host, port)
x.connect(usr, pwd)

throwOnFailure = True
assert not x.dbExists(dbn), 'Db %s should not exist' % dbn
x.createDb(dbn)
x.dbExists(dbn, throwOnFailure), 'Db %s should exist' % dbn
x.connect(usr, pwd, dbn)
assert not x.tableExists('xyz'), 'Table should not exist'
x.loadSqlScript(os.path.join(sqlDir, 'setup_DB_global.sql'), usr, pwd, dbn)
x.tableExists('RunInfo', throwOnFailure)
x.dropDb(dbn)
assert not x.dbExists(dbn), "droppped db '%s', but still exists" % dbn
