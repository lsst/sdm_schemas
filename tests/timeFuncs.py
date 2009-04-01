#!/usr/bin/env python

import unittest
import os
import re
import time

import lsst.daf.persistence as dafPersist

class TimeFuncTestCase(unittest.TestCase):
    """A test case for SQL time functions."""

    def setUp(self):
        self.testId = int(time.time() * 10.0)
        self.db = dafPersist.DbStorage()
        self.db.setRetrieveLocation(dafPersist.LogicalLocation(
            "mysql://lsst10.ncsa.uiuc.edu:3306/test"))

        self.db.startTransaction()
        self.db.executeSql("CREATE DATABASE test_%d" % self.testId)
        self.db.endTransaction()

        self.db.setRetrieveLocation(dafPersist.LogicalLocation(
            "mysql://lsst10.ncsa.uiuc.edu:3306/test_%d" % self.testId))

        f = open(os.path.join(os.environ['CAT_DIR'], "sql",
            "setup_storedFunctions.sql"), "r")
        delimiter = ";"
        statement = ""
        for l in f.xreadlines():
            if re.match(r'$|--$|--\s', l):
                continue
            l = re.sub(r'\s+--\s.*', "", l)
            m = re.match(r'DELIMITER (//|;)', l)
            if m:
                delimiter = m.group(1)
                continue
            if re.search(delimiter + r'\s*\S', l):
                raise RuntimeError, "Text after delimiter"
            if re.search(delimiter + r'\s*$', l):
                self.db.startTransaction()
                self.db.executeSql(statement +
                        re.sub(delimiter + '\s*$', "", l))
                self.db.endTransaction()
                statement = ""
            else:
                statement += l

        self.db.startTransaction()
        self.db.setTableForQuery("DUAL", True)

    def tearDown(self):
        self.db.endTransaction()

        self.db.startTransaction()
        self.db.executeSql("DROP DATABASE test_%d" % self.testId)
        self.db.endTransaction()

    def testMJD(self):
        mjdUtc = 45205.125
        self.db.outColumn("taiToUtc(mjdUtcToTai(%f))" % mjdUtc, True)
        self.db.outColumn("mjdUtcToTai(%f)" % mjdUtc, True)
        self.db.outColumn("taiToMjdUtc(mjdUtcToTai(%f))" % mjdUtc, True)
        self.db.outColumn("taiToMjdTai(mjdUtcToTai(%f))" % mjdUtc, True)
        self.db.query()
        haveRow = self.db.next()
        self.assert_(haveRow)
        self.assertEqual(self.db.getColumnByPosInt64(0), 399006000000000000L)
        self.assertEqual(self.db.getColumnByPosInt64(1), 399006021000000000L)
        self.assertAlmostEqual(self.db.getColumnByPosDouble(2), 45205.125)
        self.assertAlmostEqual(self.db.getColumnByPosDouble(3),
                45205.125 + 21.0 / 86400.0)
        haveRow = self.db.next()
        self.assert_(not haveRow)

    def testNsecs(self):
        nsecsUtc = 1192755473000000000L
        self.db.outColumn("taiToUtc(utcToTai(%d))" % nsecsUtc, True)
        self.db.outColumn("utcToTai(%d)" % nsecsUtc, True)
        self.db.outColumn("taiToMjdUtc(utcToTai(%d))" % nsecsUtc, True)
        self.db.query()
        haveRow = self.db.next()
        self.assert_(haveRow)
        self.assertEqual(self.db.getColumnByPosInt64(0), 1192755473000000000L)
        self.assertEqual(self.db.getColumnByPosInt64(1), 1192755506000000000L)
        self.assertAlmostEqual(self.db.getColumnByPosDouble(2), 54392.040196759262)
        haveRow = self.db.next()
        self.assert_(not haveRow)

    def testBoundaryMJD(self):
        mjdUtc = 47892.0
        self.db.outColumn("taiToUtc(mjdUtcToTai(%f))" % mjdUtc, True)
        self.db.outColumn("mjdUtcToTai(%f)" % mjdUtc, True)
        self.db.outColumn("taiToMjdUtc(mjdUtcToTai(%f))" % mjdUtc, True)
        self.db.query()
        haveRow = self.db.next()
        self.assert_(haveRow)
        self.assertEqual(self.db.getColumnByPosInt64(0), 631152000000000000L)
        self.assertEqual(self.db.getColumnByPosInt64(1), 631152025000000000L)
        self.assertEqual(self.db.getColumnByPosDouble(2), 47892.0)
        haveRow = self.db.next()
        self.assert_(not haveRow)

    def testCrossBoundaryNsecs(self):
        nsecsUtc = 631151998000000000L
        self.db.outColumn("taiToUtc(utcToTai(%d))" % nsecsUtc, True)
        self.db.outColumn("utcToTai(%d)" % nsecsUtc, True)
        self.db.query()
        haveRow = self.db.next()
        self.assert_(haveRow)
        self.assertEqual(self.db.getColumnByPosInt64(0), 631151998000000000L)
        self.assertEqual(self.db.getColumnByPosInt64(1), 631152022000000000L)
        haveRow = self.db.next()
        self.assert_(not haveRow)

    def testNsecsTAI(self):
        nsecsTai = 1192755506000000000L
        self.db.outColumn("taiToUtc(%d)" % nsecsTai, True)
        self.db.outColumn("utcToTai(taiToUtc(%d))" % nsecsTai, True)
        self.db.outColumn("taiToMjdUtc(%d)" % nsecsTai, True)
        self.db.query()
        haveRow = self.db.next()
        self.assert_(haveRow)
        self.assertEqual(self.db.getColumnByPosInt64(0), 1192755473000000000L)
        self.assertEqual(self.db.getColumnByPosInt64(1), 1192755506000000000L)
        self.assertAlmostEqual(self.db.getColumnByPosDouble(2), 54392.040196759262)
        haveRow = self.db.next()
        self.assert_(not haveRow)

def suite():
    return unittest.makeSuite(TimeFuncTestCase)

if __name__ == '__main__':
    unittest.main()
