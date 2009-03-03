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
        subP = self.policyObj.getPolicy('database.authinfo')
        host = subP.getString('host')
        port = subP.getInt('port')
        return (host, port)
    
    def readGlobalSetup(self):
        subP = self.policyObj.getPolicy('database.globalSetup')
        gDb = subP.getString('globalDbName')
        dcVer = subP.getString('dcVersion')
        minDiskSp = subP.getInt('minPercDiskSpaceReq')
        uRunLife = subP.getInt('userRunLife')
        return (gDb, dcVer, minDiskSp, uRunLife)

    def readRunCleanup(self):
        subP = self.policyObj('database.runCleanup')
        firstN = subP.getInt('daysFirstNotice')
        finalN = subP.getInt('daysFinalNotice')
        return (firstN, finalN)
