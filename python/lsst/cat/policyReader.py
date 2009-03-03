#!/usr/bin/env python

from lsst.cat.MySQLBase import MySQLBase
from lsst.pex.logging import Log
import lsst.pex.policy as pexPolicy

import os

class PolicyReader:
    def __init__(self, fPath=None, fName=None):
        if fPath is None:
            fPath = os.environ["CAT_DIR"]
            if fPath is None:
                raise RuntimeError('CAT_DIR env var required')
        if fName is None:
            fName = 'defaultCatPolicy.paf'

        self.policyPath = os.path.join(fPath, fName)
        log = Log(Log.getDefaultLog(), "cat")
        log.log(Log.DEBUG, 'Reading policy from %s' % self.policyPath)

    def readIt(self):
        pol = pexPolicy.Policy.createPolicy(self.policyPath)
        host = pol.getString('database.authinfo.host')
        port = pol.getInt('database.authinfo.port')
        gDb = pol.getString('database.globalDbName')
        dcVer = pol.getString('database.dcVersion')

        return (host, port, gDb, dcVer)
