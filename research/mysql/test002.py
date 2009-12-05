#!/usr/local/bin/python

import MySQLdb

# near neighbor query by running mini-near neighbor once for each
# subChunkId, without building sub-chunks

# assumptions:
# x1m table (1 million rows)
# required columns: ra, decl, objectId, subChunkId int, cosRadDecl float
# cosRadDecl built as:
# alter table x1m ADD COLUMN cosRadDecl FLOAT;
# UPDATE x1m set cosRadDecl = COS(RADIANS(decl));
#
# table sorted by subChunkId using:
# myisamchk -dvv # to get key ids
# myisamchk /u1/mysql_data/usnob/x1m.MYI --sort-record=3

db = MySQLdb.connect(host='localhost',
                     user='becla',
                     passwd='',
                     db='usnob')

cursor = db.cursor()


for n in xrange(0,1000):
    print n

    cmd = 'select count(*) from x1m o1, x1m o2 WHERE o1.subChunkId=%s and o2.subChunkId=%s and ABS(o1.ra - o2.ra) < 0.00083 / o2.cosRadDecl AND ABS(o1.decl - o2.decl) < 0.00083 AND  o1.objectId <> o2.objectId' % (n,n)
    cursor.execute(cmd)

db.close()



# Dec 03, 2009, lsst-dev01:
# 0.260u 0.228s 39:29.31 0.0%	0+0k 10880+0io 267pf+0w
