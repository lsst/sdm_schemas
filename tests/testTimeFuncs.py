#!/usr/bin/env python

#
# LSST Data Management System
# Copyright 2008-14 AURA/LSST.
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


from builtins import next
import unittest
import os
import time

import lsst.daf.persistence as dafPersist
import lsst.cat.SqlScript as SqlScript
import lsst.utils.tests

DB_HOST = "lsst10.ncsa.illinois.edu"
DB_PORT = 3306

if os.uname()[1].endswith(".ncsa.illinois.edu") and \
        dafPersist.DbAuth.available(DB_HOST, str(DB_PORT)):
    HAVE_DB = True
else:
    HAVE_DB = False


class TimeFuncTestCase(lsst.utils.tests.TestCase):
    """A test case for SQL time functions."""

    def setUp(self):

        if not HAVE_DB:
            raise unittest.SkipTest("not at NCSA or no database credentials.")

        testId = int(time.time() * 10.0)

        self.dbName = "test_%d" % testId
        dbUrl = "mysql://{}:{}/".format(DB_HOST, DB_PORT) + self.dbName

        self.db = dafPersist.DbStorage()

        self.db.setRetrieveLocation(dafPersist.LogicalLocation(
            "mysql://{}:{}/test".format(DB_HOST, DB_PORT)))
        self.db.startTransaction()
        self.db.executeSql("CREATE DATABASE " + self.dbName)
        self.db.endTransaction()

        SqlScript.run(os.path.join(os.environ['CAT_DIR'], "sql",
                                   "lsstSchema4mysqlPT1_2.sql"), dbUrl)
        SqlScript.run(os.path.join(os.environ['CAT_DIR'], "sql",
                                   "setup_perRunTablesS12_lsstsim.sql"), dbUrl)
        SqlScript.run(os.path.join(os.environ['CAT_DIR'], "sql",
                                   "setup_storedFunctions.sql"), dbUrl)

        self.db.setRetrieveLocation(dafPersist.LogicalLocation(dbUrl))

        self.db.startTransaction()
        self.db.setTableForQuery("DUAL", True)

    def tearDown(self):
        self.db.endTransaction()

        self.db.startTransaction()
        self.db.executeSql("DROP DATABASE " + self.dbName)
        self.db.endTransaction()

    def testMJD(self):
        mjdUtc = 45205.125
        self.db.outColumn("taiToUtc(mjdUtcToTai(%f))" % mjdUtc, True)
        self.db.outColumn("mjdUtcToTai(%f)" % mjdUtc, True)
        self.db.outColumn("taiToMjdUtc(mjdUtcToTai(%f))" % mjdUtc, True)
        self.db.outColumn("taiToMjdTai(mjdUtcToTai(%f))" % mjdUtc, True)
        self.db.query()
        haveRow = next(self.db)
        self.assertTrue(haveRow)
        self.assertEqual(self.db.getColumnByPosInt64(0), 399006000000000000)
        self.assertEqual(self.db.getColumnByPosInt64(1), 399006021000000000)
        self.assertAlmostEqual(self.db.getColumnByPosDouble(2), 45205.125)
        self.assertAlmostEqual(self.db.getColumnByPosDouble(3),
                               45205.125 + 21.0 / 86400.0)
        haveRow = next(self.db)
        self.assertFalse(haveRow)

    def testNsecs(self):
        nsecsUtc = 1192755473000000000
        self.db.outColumn("taiToUtc(utcToTai(%d))" % nsecsUtc, True)
        self.db.outColumn("utcToTai(%d)" % nsecsUtc, True)
        self.db.outColumn("taiToMjdUtc(utcToTai(%d))" % nsecsUtc, True)
        self.db.query()
        haveRow = next(self.db)
        self.assertTrue(haveRow)
        self.assertEqual(self.db.getColumnByPosInt64(0), 1192755473000000000)
        self.assertEqual(self.db.getColumnByPosInt64(1), 1192755506000000000)
        self.assertAlmostEqual(self.db.getColumnByPosDouble(2), 54392.040196759262)
        haveRow = next(self.db)
        self.assertFalse(haveRow)

    def testBoundaryMJD(self):
        mjdUtc = 47892.0
        self.db.outColumn("taiToUtc(mjdUtcToTai(%f))" % mjdUtc, True)
        self.db.outColumn("mjdUtcToTai(%f)" % mjdUtc, True)
        self.db.outColumn("taiToMjdUtc(mjdUtcToTai(%f))" % mjdUtc, True)
        self.db.query()
        haveRow = next(self.db)
        self.assertTrue(haveRow)
        self.assertEqual(self.db.getColumnByPosInt64(0), 631152000000000000)
        self.assertEqual(self.db.getColumnByPosInt64(1), 631152025000000000)
        self.assertEqual(self.db.getColumnByPosDouble(2), 47892.0)
        haveRow = next(self.db)
        self.assertFalse(haveRow)

    def testCrossBoundaryNsecs(self):
        nsecsUtc = 631151998000000000
        self.db.outColumn("taiToUtc(utcToTai(%d))" % nsecsUtc, True)
        self.db.outColumn("utcToTai(%d)" % nsecsUtc, True)
        self.db.query()
        haveRow = next(self.db)
        self.assertTrue(haveRow)
        self.assertEqual(self.db.getColumnByPosInt64(0), 631151998000000000)
        self.assertEqual(self.db.getColumnByPosInt64(1), 631152022000000000)
        haveRow = next(self.db)
        self.assertFalse(haveRow)

    def testNsecsTAI(self):
        nsecsTai = 1192755506000000000
        self.db.outColumn("taiToUtc(%d)" % nsecsTai, True)
        self.db.outColumn("utcToTai(taiToUtc(%d))" % nsecsTai, True)
        self.db.outColumn("taiToMjdUtc(%d)" % nsecsTai, True)
        self.db.query()
        haveRow = next(self.db)
        self.assertTrue(haveRow)
        self.assertEqual(self.db.getColumnByPosInt64(0), 1192755473000000000)
        self.assertEqual(self.db.getColumnByPosInt64(1), 1192755506000000000)
        self.assertAlmostEqual(self.db.getColumnByPosDouble(2), 54392.040196759262)
        haveRow = next(self.db)
        self.assertFalse(not haveRow)


class MemoryTester(lsst.utils.tests.MemoryTestCase):
    pass


def setup_module(module):
    lsst.utils.tests.init()

if __name__ == "__main__":
    lsst.utils.tests.init()
    unittest.main()
