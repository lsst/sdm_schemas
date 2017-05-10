#!/usr/bin/env python

"""Unit test for time-related functions defined in
sql/setup_storedFunctions.sql.

The test requires credential file ~/.lsst/dbAuth-testTimeFuncs.ini
with the contents which looks like (replace with actual values):

[database]
url = mysql+mysqldb://<userName>:<password>@<host>:<port>/
"""

#
# LSST Data Management System
# Copyright 2008-17 AURA/LSST.
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


import unittest
import os
import time

from lsst.db.utils import createDb, dropDb, loadSqlScript
from lsst.db.engineFactory import getEngineFromFile
from sqlalchemy.sql import text
import lsst.utils.tests


class TimeFuncTestCase(lsst.utils.tests.TestCase):
    """A test case for SQL time functions."""

    CREDFILE = "~/.lsst/dbAuth-testTimeFuncs.ini"

    dbName = None
    engine = None

    @classmethod
    def setUpClass(cls):

        try:
            engine = getEngineFromFile(cls.CREDFILE)
        except IOError:
            raise unittest.SkipTest("%s: No credentials file %s, skipping tests." %
                                    (cls.__name__, cls.CREDFILE))

        username = engine.url.username
        testId = int(time.time() * 10.0)
        cls.dbName = "%s_test_%d" % (username, testId)

        # make temporary database
        createDb(engine, cls.dbName)

        # make engine with database name
        cls.engine = getEngineFromFile(cls.CREDFILE, database=cls.dbName)

        # load scripts
        scripts = ["lsstSchema4mysqlPT1_2.sql",
                   "setup_perRunTablesS12_lsstsim.sql",
                   "setup_storedFunctions.sql"]
        sqldir = os.path.join(lsst.utils.getPackageDir("cat"), "sql")
        for script in scripts:
            loadSqlScript(cls.engine, os.path.join(sqldir, script))

    @classmethod
    def tearDownClass(cls):
        # drop temporary database
        dropDb(cls.engine, cls.dbName)
        cls.engine = None

    def setUp(self):
        pass

    def tearDown(self):
        pass

    def testMJD(self):
        with self.engine.begin() as conn:
            mjdUtc = 45205.125
            query = text("SELECT taiToUtc(mjdUtcToTai(:mjdUtc)), "
                         "mjdUtcToTai(:mjdUtc), "
                         "taiToMjdUtc(mjdUtcToTai(:mjdUtc)), "
                         "taiToMjdTai(mjdUtcToTai(:mjdUtc))")
            result = conn.execute(query, mjdUtc=mjdUtc)
            row = result.fetchone()
            self.assertIsNotNone(row)
            self.assertEqual(row[0], 399006000000000000)
            self.assertEqual(row[1], 399006021000000000)
            self.assertAlmostEqual(row[2], 45205.125)
            self.assertAlmostEqual(row[3], 45205.125 + 21.0 / 86400.0)

    def testNsecs(self):
        with self.engine.begin() as conn:
            nsecsUtc = 1192755473000000000
            query = text("SELECT taiToUtc(utcToTai(:nsecsUtc)), "
                         "utcToTai(:nsecsUtc), "
                         "taiToMjdUtc(utcToTai(:nsecsUtc))")
            result = conn.execute(query, nsecsUtc=nsecsUtc)
            row = result.fetchone()
            self.assertIsNotNone(row)
            self.assertEqual(row[0], 1192755473000000000)
            self.assertEqual(row[1], 1192755506000000000)
            self.assertAlmostEqual(row[2], 54392.040196759262)

    def testBoundaryMJD(self):
        with self.engine.begin() as conn:
            mjdUtc = 47892.0
            query = text("SELECT taiToUtc(mjdUtcToTai(:mjdUtc)), "
                         "mjdUtcToTai(:mjdUtc), "
                         "taiToMjdUtc(mjdUtcToTai(:mjdUtc))")
            result = conn.execute(query, mjdUtc=mjdUtc)
            row = result.fetchone()
            self.assertIsNotNone(row)
            self.assertEqual(row[0], 631152000000000000)
            self.assertEqual(row[1], 631152025000000000)
            self.assertEqual(row[2], 47892.0)

    def testCrossBoundaryNsecs(self):
        with self.engine.begin() as conn:
            nsecsUtc = 631151998000000000
            query = text("SELECT taiToUtc(utcToTai(:nsecsUtc)), "
                         "utcToTai(:nsecsUtc)")
            result = conn.execute(query, nsecsUtc=nsecsUtc)
            row = result.fetchone()
            self.assertIsNotNone(row)
            self.assertEqual(row[0], 631151998000000000)
            self.assertEqual(row[1], 631152022000000000)

    def testNsecsTAI(self):
        with self.engine.begin() as conn:
            nsecsTai = 1192755506000000000
            query = text("SELECT taiToUtc(:nsecsTai), "
                         "utcToTai(taiToUtc(:nsecsTai)), "
                         "taiToMjdUtc(:nsecsTai)")
            result = conn.execute(query, nsecsTai=nsecsTai)
            row = result.fetchone()
            self.assertIsNotNone(row)
            self.assertEqual(row[0], 1192755473000000000)
            self.assertEqual(row[1], 1192755506000000000)
            self.assertAlmostEqual(row[2], 54392.040196759262)


class MemoryTester(lsst.utils.tests.MemoryTestCase):
    pass


def setup_module(module):
    lsst.utils.tests.init()

if __name__ == "__main__":
    lsst.utils.tests.init()
    unittest.main()
