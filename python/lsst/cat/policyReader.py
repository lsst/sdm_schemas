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

        policyPath = os.path.join(fPath, fName)
        self.policyObj = pexPolicy.Policy.createPolicy(policyPath)

        log = Log(Log.getDefaultLog(), "cat")
        log.log(Log.DEBUG, 'Reading policy from %s' % policyPath)

    def readAuthInfo(self):
        loc = 'database.authinfo'
        host = self.policyObj.getString('%s.host' % loc)
        port = self.policyObj.getInt('%s.port' % loc)
        return (host, port)
    
    def readGlobalSetup(self):
        loc = 'database.globalSetup'
        gDb = self.policyObj.getString('%s.globalDbName' % loc)
        dcVer = self.policyObj.getString('%s.dcVersion' % loc)
        minDiskSp = self.policyObj.getInt('%s.minPercDiskSpaceReq' % loc)
        uRunLife = self.policyObj.getInt('%s.userRunLife' % loc)
        return (gDb, dcVer, minDiskSp, uRunLife)

    def readRunCleanup(self):
        loc = 'database.runCleanup'
        firstN = self.policyObj.getInt('%s.daysFirstNotice' % loc)
        finalN = self.policyObj.getInt('%s.daysFinalNotice' % loc)
        return (firstN, finalN)
