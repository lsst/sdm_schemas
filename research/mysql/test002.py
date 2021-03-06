#!/usr/local/bin/python

#
# LSST Data Management System
# Copyright 2008, 2009, 2010 LSST Corporation.
#
# This product includes software developed by the
# LSST Project (http://www.lsst.org/).
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the LSST License Statement and
# the GNU General Public License along with this program.  If not,
# see <http://www.lsstcorp.org/LegalNotices/>.
#

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


for n in range(0, 1000):
    print(n)

    cmd = 'select count(*) from x1m o1, x1m o2 WHERE o1.subChunkId=%s and o2.subChunkId=%s and ABS(o1.ra - o2.ra) < 0.00083 / o2.cosRadDecl AND ABS(o1.decl - o2.decl) < 0.00083 AND  o1.objectId <> o2.objectId' % (n, n)
    cursor.execute(cmd)

db.close()


# Dec 03, 2009, lsst-dev01:
# 0.260u 0.228s 39:29.31 0.0%	0+0k 10880+0io 267pf+0w
