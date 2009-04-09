#!/usr/bin/env python

from __future__ import with_statement

import optparse
import os
import re

import lsst.daf.persistence as dafPersist

defaultDbUrl='mysql://lsst10.ncsa.uiuc.edu:3306/test'

def parse(filename):
    statements = []
    with open(filename, "r") as f:
        delimiter = ";"
        statement = ""
        for l in f:
            if re.match(r'$|--$|--\s', l):
                continue
            l = re.sub(r'\s+--\s.*', "", l)
            m = re.match(r'DELIMITER (//|;)', l, flags=re.I)
            if m:
                delimiter = m.group(1)
                continue
            if re.search(delimiter + r'\s*\S', l):
                raise RuntimeError, "Non-comment text after delimiter: %s" % l
            if re.search(delimiter + r'\s*$', l):
                l = re.sub(delimiter + r'\s*$', "", l)
                statements.append(statement + l)
                statement = ""
            else:
                statement += l
    return statements

def run(filename, dbUrl=defaultDbUrl):
    db = dafPersist.DbStorage()
    db.setRetrieveLocation(dafPersist.LogicalLocation(dbUrl))

    statements = parse(filename)
    for s in statements:
        db.startTransaction()
        db.executeSql(s)
        db.endTransaction()

def main():
    parser = optparse.OptionParser("usage: %prog [options] SQLFILE ...")
    parser.add_option('-d', '--db', dest='dbUrl', type='string',
            action='store', default=defaultDbUrl,
            help=
'specify URL for db, including host, port, and database; default is: %s' % defaultDbUrl)

    (options, args) = parser.parse_args()
    if len(args) < 1:
        parser.error("Missing required SQLFILE argument")
    for f in args:
        run(f, options.dbUrl)

if __name__ == '__main__':
    main()
