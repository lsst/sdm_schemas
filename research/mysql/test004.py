#!/usr/local/bin/python

import MySQLdb

# building sub-partitions

# assumptions:
# x100k table (100k rows)
# required columns: subChunkId
# It can be built eg by doing
# update x100k set subChunkId=objectId%100;
#
#
# table cab be sorted by subChunkId using:
# myisamchk -dvv # to get key ids
# myisamchk /u1/mysql_data/usnob/x100k.MYI --sort-record=3


db = MySQLdb.connect(host='localhost',
                     user='becla',
                     passwd='',
                     db='usnob')

cursor = db.cursor()

for n in xrange(1,100):
    cmd = 'CREATE TABLE sp_%s ENGINE=MEMORY SELECT * FROM x100k where subChunkId=%s' % (n,n)
    #cmd = 'DROP TABLE sp_%s' % (n)
    cursor.execute(cmd)

db.close()
