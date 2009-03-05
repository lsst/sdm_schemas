#!/usr/bin/env python

from lsst.cat.dbSetup.py import DbSetup
from lsst.cat.policyReader import PolicyReader


r = PolicyReader(policyF)
(host, port) = r.readAuthInfo()

usr = raw_input("Enter mysql account name: ")
pwd = getpass.getpass()

x = DbSetup(host, port, usr, pwd)
x.setupUserDb()
