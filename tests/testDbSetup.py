#!/usr/bin/env python

# 
# LSST Data Management System
# Copyright 2008, 2009, 2010, 2014 LSST Corporation.
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

import logging

from lsst.cat.dbSetup import DbSetup
from lsst.db.utils import readCredentialFile

# We want the user name and password so a database can be opened.
creds = readCredentialFile("~/.mysqlAuthLSST", logging.getLogger("lsst.cat.test"))
usr = creds['user']
host = creds['host']
port = int(creds['port'])
pwd = creds['passwd']

# This opens a database and creates tables using default values of
# "<usr>_dev" for the database name and the cat sql scripts.
x = DbSetup(host, port, usr, pwd)
x.setupUserDb()

assert(x.tableExists("MovingObject") == True)

x.disconnect()
